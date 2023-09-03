import compiler_register_allocator as compiler
from compiler import Temporaries, get_fresh_tmp
from compiler_register_allocator import get_loc_from_arg, label
from ast import *
from x86_ast import *
from utils import *
from graph import *
from dataflow_analysis import analyze_dataflow

registers_for_coloring = [
    Reg('rcx'),
    Reg('rdx'),
    Reg('rsi'),
    Reg('r8'),
    Reg('r9'),
    Reg('r10'),
    Reg('r11'),
    Reg('r15'),
]


def create_block(stmts, basic_blocks):
    match stmts:
        case [Goto(l)]:
            return stmts
        case _:
            label = label_name(generate_name('block'))
            basic_blocks[label] = stmts
            return [Goto(label)]


def cc(op):
    match op:
        case Eq():
            return 'e'
        case NotEq():
            return 'ne'
        case Lt():
            return 'l'
        case LtE():
            return 'le'
        case Gt():
            return 'g'
        case GtE():
            return 'ge'


class Compiler(compiler.Compiler):

    ###########################################################################
    # Shrink
    ###########################################################################

    def shrink_exp(self, e: expr) -> expr:
        match e:
            case Constant(_) | Name(_):
                return e
            case BoolOp(And(), [e1, e2]):
                return IfExp(self.shrink_exp(e1), self.shrink_exp(e2), Constant(False))
            case BoolOp(Or(), [e1, e2]):
                return IfExp(self.shrink_exp(e1), Constant(True), self.shrink_exp(e2))
            case IfExp(e1, e2, e3):
                return IfExp(
                    self.shrink_exp(e1), self.shrink_exp(e2), self.shrink_exp(e3)
                )
            case Compare(left, [op], [right]):
                return Compare(self.shrink_exp(left), [op], [self.shrink_exp(right)])
            case BinOp(e1, op, e2):
                return BinOp(self.shrink_exp(e1), op, self.shrink_exp(e2))
            case UnaryOp(op, operand):
                return UnaryOp(op, self.shrink_exp(operand))
            case Call(Name('input_int'), []):
                return e
            case _:
                raise Exception('unhandled case in shrink_exp:' + repr(e))

    def shrink_stmt(self, s: stmt) -> stmt:
        match s:
            case If(test, thn, els):
                test_shrink = self.shrink_exp(test)
                thn_shrink = []
                for s in thn:
                    thn_shrink.append(self.shrink_stmt(s))
                els_shrink = []
                for s in els:
                    els_shrink.append(self.shrink_stmt(s))
                return If(test_shrink, thn_shrink, els_shrink)
            case While(test, body, []):
                body_shrink = []
                for s in body:
                    body_shrink.append(self.shrink_stmt(s))
                return While(self.shrink_exp(test), body_shrink, [])
            case Expr(Call(Name('print'), [arg])):
                return Expr(Call(Name('print'), [self.shrink_exp(arg)]))
            case Expr(e):
                return Expr(self.shrink_exp(e))
            case Assign(lhs, rhs):
                return Assign(lhs, self.shrink_exp(rhs))
            case _:
                raise Exception('unhandled case in shrink_stmt:' + repr(s))

    def shrink(self, p: Module) -> Module:
        new_body = []
        for stm in p.body:
            new_body.append(self.shrink_stmt(stm))
        return Module(new_body)

    ############################################################################
    # Remove Complex Operands
    ############################################################################

    def rco_exp(self, e: expr, need_atomic: bool) -> tuple[expr, Temporaries]:
        match e:
            case Name(_) | Constant(_):
                return (e, [])
            case Call(Name('input_int'), []):
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (Name(fresh_tmp), [(Name(fresh_tmp), e)])
                return (e, [])
            case UnaryOp(USub(), e1):
                atm, tmps = self.rco_exp(e1, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps + [(Name(fresh_tmp), UnaryOp(USub(), atm))],
                    )
                return (UnaryOp(USub(), atm), tmps)
            case BinOp(e1, op, e2):
                atm1, tmps1 = self.rco_exp(e1, True)
                atm2, tmps2 = self.rco_exp(e2, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps1 + tmps2 + [(Name(fresh_tmp), BinOp(atm1, op, atm2))],
                    )
                return (BinOp(atm1, op, atm2), tmps1 + tmps2)
            case BoolOp(op, [e1, e2]):
                atm1, tmps1 = self.rco_exp(e1, True)
                atm2, tmps2 = self.rco_exp(e2, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps1 + tmps2 + [(Name(fresh_tmp), BoolOp(op, [atm1, atm2]))],
                    )
                return (BoolOp(op, [atm1, atm2]), tmps1 + tmps2)

            case Compare(left, [op], [right]):
                atml, tmpsl = self.rco_exp(left, True)
                atmr, tmpsr = self.rco_exp(right, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmpsl
                        + tmpsr
                        + [(Name(fresh_tmp), Compare(atml, [op], [atmr]))],
                    )
                return (Compare(atml, [op], [atmr]), tmpsl + tmpsr)
            case IfExp(e1, e2, e3):
                atm1, tmps1 = self.rco_exp(e1, False)
                atm2, tmps2 = self.rco_exp(e2, False)
                atm3, tmps3 = self.rco_exp(e3, False)

                begin1 = self.tmps_to_stmts(tmps1)
                begin2 = self.tmps_to_stmts(tmps2)
                begin3 = self.tmps_to_stmts(tmps3)

                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        [
                            (
                                Name(fresh_tmp),
                                IfExp(
                                    Begin(begin1, atm1),
                                    Begin(begin2, atm2),
                                    Begin(begin3, atm3),
                                ),
                            )
                        ],
                    )

                return (
                    IfExp(
                        Begin(begin1, atm1), Begin(begin2, atm2), Begin(begin3, atm3)
                    ),
                    [],
                )
            case _:
                raise Exception('unhandled case in rco_exp ' + repr(e))

    def rco_stmt(self, s: stmt) -> list[stmt]:
        match s:
            case Expr(Call(Name('print'), [e])):
                atm, tmps = self.rco_exp(e, True)
                return self.tmps_to_stmts(tmps) + [Expr(Call(Name('print'), [atm]))]
            case Expr(e):
                atm, tmps = self.rco_exp(e, False)
                return self.tmps_to_stmts(tmps) + [Expr(atm)]
            case Assign([Name(var)], e):
                atm, tmps = self.rco_exp(e, False)
                return self.tmps_to_stmts(tmps) + [Assign([Name(var)], atm)]
            case If(test, thn, els):
                atm, tmps = self.rco_exp(test, False)

                rco_thn = []
                for s in thn:
                    rco_thn += self.rco_stmt(s)

                rco_els = []
                for s in els:
                    rco_els += self.rco_stmt(s)

                return self.tmps_to_stmts(tmps) + [If(atm, rco_thn, rco_els)]
            case While(test, body, []):
                atm, tmps = self.rco_exp(test, False)

                rco_body = []
                for s in body:
                    rco_body += self.rco_stmt(s)

                return self.tmps_to_stmts(tmps) + [While(atm, rco_body, [])]
            case _:
                raise Exception('unhandled case in rco_stmt ' + repr(s))

    ############################################################################
    # Explicate Control
    ############################################################################

    def explicate_effect(self, e, cont, basic_blocks) -> list[stmt]:
        match e:
            case IfExp(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)
                body_instr = self.explicate_effect(body, goto_cont, basic_blocks)
                orelse_instr = self.explicate_effect(orelse, goto_cont, basic_blocks)

                return self.explicate_pred(test, body_instr, orelse_instr, basic_blocks)
            case Call(func, args):
                return [Expr(e)] + cont
            case Begin(body, result):
                new_body = self.epxlicate_effect(result, cont, basic_blocks) + [cont]
                for s in reversed(body):
                    new_body = self.epxlicate_stmt(s, new_body, basic_blocks)
                return new_body
            case _:
                return cont

    def explicate_assign(self, rhs, lhs, cont, basic_blocks) -> list[stmt]:
        match rhs:
            case IfExp(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)

                body_instr = self.explicate_assign(body, lhs, goto_cont, basic_blocks)
                orelse_instr = self.explicate_assign(
                    orelse, lhs, goto_cont, basic_blocks
                )

                return self.explicate_pred(test, body_instr, orelse_instr, basic_blocks)
            case Begin(body, result):
                new_body = self.explicate_assign(result, lhs, cont, basic_blocks)
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)
                return new_body
            case _:
                return [Assign([lhs], rhs)] + cont

    def explicate_pred(self, cnd, thn, els, basic_blocks) -> list[stmt]:
        match cnd:
            case Compare(left, [op], [right]):
                goto_thn = create_block(thn, basic_blocks)
                goto_els = create_block(els, basic_blocks)

                return [If(cnd, goto_thn, goto_els)]
            case Constant(True):
                return thn
            case Constant(False):
                return els
            case UnaryOp(Not(), operand):
                return self.explicate_pred(operand, els, thn, basic_blocks)
            case IfExp(test, body, orelse):
                goto_thn = create_block(thn, basic_blocks)
                goto_els = create_block(els, basic_blocks)

                new_body_if_cond = self.explicate_pred(
                    body, goto_thn, goto_els, basic_blocks
                )

                new_orelse_if_cond = self.explicate_pred(
                    orelse, goto_thn, goto_els, basic_blocks
                )

                return self.explicate_pred(
                    test, new_body_if_cond, new_orelse_if_cond, basic_blocks
                )
            case Begin(body, result):
                new_body = self.explicate_pred(result, thn, els, basic_blocks)
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)

                return new_body
            case _:
                return [
                    If(
                        Compare(cnd, [Eq()], [Constant(False)]),
                        create_block(els, basic_blocks),
                        create_block(thn, basic_blocks),
                    )
                ]

    def explicate_stmt(self, s: stmt, cont, basic_blocks) -> list[stmt]:
        match s:
            case Assign([lhs], rhs):
                return self.explicate_assign(rhs, lhs, cont, basic_blocks)
            case Expr(value):
                return self.explicate_effect(value, cont, basic_blocks)
            case If(test, body, orelse):
                goto_cont = create_block(cont, basic_blocks)

                explicate_body = []
                explicate_body += goto_cont
                for s in reversed(body):
                    explicate_body = self.explicate_stmt(
                        s, explicate_body, basic_blocks
                    )

                explicate_orelse = []
                explicate_orelse += goto_cont
                for s in reversed(orelse):
                    explicate_orelse = self.explicate_stmt(
                        s, explicate_orelse, basic_blocks
                    )

                return self.explicate_pred(
                    test, explicate_body, explicate_orelse, basic_blocks
                )
            case While(test, body, []):
                goto_cont = create_block(cont, basic_blocks)

                label = label_name(generate_name('loop'))
                goto_loop = [Goto(label)]

                explicate_body = goto_loop
                for s in reversed(body):
                    explicate_body = self.explicate_stmt(
                        s, explicate_body, basic_blocks
                    )

                basic_blocks[label] = self.explicate_pred(
                    test, explicate_body, goto_cont, basic_blocks
                )

                return goto_loop
            case _:
                raise Exception('unhandled case in explicate_stmt: ' + repr(s))

    def explicate_control(self, p: Module):
        match p:
            case Module(body):
                new_body = [Return(Constant(0))]
                basic_blocks = {}
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)
                basic_blocks[label_name('start')] = new_body
                return CProgram(basic_blocks)

    ############################################################################
    # Select Instructions
    ############################################################################

    def select_arg(self, e: expr) -> arg:
        match e:
            case Constant(True):
                return Immediate(1)
            case Constant(False):
                return Immediate(0)
            case _:
                return super().select_arg(e)

    def select_assign(self, s: stmt) -> list[instr]:
        match s:
            case Assign([Name(var)], Compare(left, [op], [right])):
                return [
                    Instr('cmpq', [self.select_arg(right), self.select_arg(left)]),
                    Instr('set' + cc(op), [ByteReg('al')]),
                    Instr('movzbq', [ByteReg('al'), Variable(var)]),
                ]
            case Assign([Name(var)], UnaryOp(Not(), atm)):
                arg = self.select_arg(atm)
                lhs = Variable(var)
                if lhs == arg:
                    return [Instr('xorq', [Immediate(1), Variable(var)])]
                else:
                    return [
                        Instr('movq', [self.select_arg(arg), Variable(var)]),
                        Instr('xorq', [Immediate(1), Variable(var)]),
                    ]
            case _:
                return super().select_assign(s)

    def select_stmt(self, s: stmt) -> list[instr]:
        match s:
            case If(Compare(left, [op], [right]), [Goto(thn)], [Goto(els)]):
                return [
                    Instr('cmpq', [self.select_arg(right), self.select_arg(left)]),
                    JumpIf(cc(op), thn),
                    Jump(els),
                ]
                return result
            case Goto(label):
                return [Jump(label)]
            case Return(arg):
                return [
                    Instr('movq', [self.select_arg(arg), Reg('rax')]),
                    Jump('conclusion'),
                ]
            case _:
                return super().select_stmt(s)

    def select_instructions(self, p: Module) -> X86Program:
        new_body = {}
        for block_id, stmts in p.body.items():
            instrs = []
            for s in stmts:
                s = self.select_stmt(s)
                instrs += s
            new_body[block_id] = instrs

        return X86Program(new_body)

    ###########################################################################
    # Uncover Live
    ###########################################################################

    def read_vars(self, i: instr) -> set[location]:
        match i:
            case Instr('movq', [s, d]) | Instr('movzbq', [s, d]):
                return get_loc_from_arg(s)
            case Instr('addq', [s, d]) | Instr('subq', [s, d]) | Instr('xorq', [s, d]):
                return get_loc_from_arg(s) | get_loc_from_arg(d)
            case Instr('cmpq', [s, d]):
                return get_loc_from_arg(s) | get_loc_from_arg(d)
            case Instr('negq', [d]):
                return get_loc_from_arg(d)
            case Instr('pushq', [d]):
                return get_loc_from_arg(d)
            case Callq(_, n):
                return set([Reg('rdi')]) if n == 1 else set()
            case _:
                return set()

    def write_vars(self, i: instr) -> set[location]:
        match i:
            case Instr('movq', [s, d]) | Instr('movzbq', [s, d]):
                return get_loc_from_arg(d)
            case Instr('addq', [s, d]) | Instr('subq', [s, d]) | Instr('xorq', [s, d]):
                return get_loc_from_arg(d)
            case Instr(op, [d]) if 'set' in op:
                return get_loc_from_arg(d)
            case Instr('negq', [d]) | Instr('pushq', [d]):
                return get_loc_from_arg(d)
            case Callq(_, n):
                return set([Reg('rax')])
            case _:
                return set()

    def control_flow_graph(
        self, basic_blocks: dict[str, list[instr]]
    ) -> DirectedAdjList:
        cfg = DirectedAdjList()

        for block_id, block_items in basic_blocks.items():
            for i in block_items:
                match i:
                    case Jump(label):
                        cfg.add_edge(block_id, label)
                    case JumpIf(_, label):
                        cfg.add_edge(block_id, label)

        return cfg

    def transfer(self, basic_blocks, block_id, l_after: set[location]):
        if block_id == 'conclusion':
            l_before = set([Reg('rax'), Reg('rsp')])
        else:
            l_before = set()

        for instr in reversed(basic_blocks[block_id]):
            self.instr_to_lafter[instr] = l_after
            l_before = (l_after - self.write_vars(instr)) | self.read_vars(instr)
            l_after = l_before

        self.block_to_lafter[block_id] = l_after
        return l_before

    def uncover_live_blocks(self, basic_blocks) -> dict[instr, set[location]]:
        cfg = self.control_flow_graph(basic_blocks)

        self.block_to_lafter = {}
        self.instr_to_lafter = {}

        analyze_dataflow(
            transpose(cfg),
            lambda label, l_after: self.transfer(basic_blocks, label, l_after),
            set(),
            lambda a, b: a.union(b),
        )

        return self.instr_to_lafter

    ############################################################################
    # Build Interference
    ############################################################################

    def build_interference(self, p: X86Program, live_blocks) -> UndirectedAdjList:
        graph = UndirectedAdjList(vertex_label=label)

        for (_, vs) in live_blocks.items():
            for v in vs:
                graph.add_vertex(v)

        for block_id, instrs in p.body.items():
            for instr in instrs:
                l_after = live_blocks[instr]
                match instr:
                    case Instr('movq', [s, d]) | Instr('movzbq', [s, d]):
                        for v in l_after:
                            if v != s and v != d and not graph.has_edge(v, d):
                                graph.add_edge(v, d)
                    case _:
                        for v in l_after:
                            for d in self.write_vars(instr):
                                if v != d and not graph.has_edge(v, d):
                                    graph.add_edge(v, d)

        return graph

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes(self, p: X86Program) -> X86Program:
        # for liveness analysis there needs to be a dummy block for conclusion
        p.body['conclusion'] = []

        live_blocks = self.uncover_live_blocks(p.body)
        rig = self.build_interference(p, live_blocks)
        home = self.color_graph(rig, registers_for_coloring)

        new_body = {}
        for block_id, instrs in p.body.items():
            new_body[block_id] = super().assign_homes_instrs(instrs, home)

        return X86Program(new_body)

    ###########################################################################
    # Patch Instructions
    ###########################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        match i:
            case Instr('cmpq', [arg, Immediate(n)]):
                return [
                    Instr('movq', [Immediate(n), Reg('rax')]),
                    Instr('cmpq', [arg, Reg('rax')]),
                ]
            case Instr('movzbq', [arg, Deref(reg, offset)]):
                return [
                    Instr('movzbq', [arg, Reg('rax')]),
                    Instr('movq', [Reg('rax'), Deref(reg, offset)]),
                ]
            case _:
                return super().patch_instr(i)

    def patch_instructions(self, p: X86Program) -> X86Program:
        new_body = {}

        for block_id, block_items in p.body.items():
            new_body[block_id] = super().patch_instrs(block_items)

        return X86Program(new_body)

    ###########################################################################
    # Prelude & Conclusion
    ###########################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        adjust_stack_size = (
            self.stack_size if self.stack_size % 16 == 0 else self.stack_size + 8
        )

        prelude = [
            Instr("pushq", [Reg("rbp")]),
            Instr("movq", [Reg("rsp"), Reg("rbp")]),
        ]
        if adjust_stack_size > 0:
            prelude.append(Instr('subq', [Immediate(adjust_stack_size), Reg('rsp')]))

        p.body['main'] = prelude + [Jump('start')]
        conclusion = [Instr('popq', [Reg('rbp')]), Instr('retq', [])]

        if adjust_stack_size > 0:
            conclusion.insert(
                0, Instr('addq', [Immediate(adjust_stack_size), Reg('rsp')])
            )

        p.body['conclusion'] = conclusion
        return X86Program(p.body)

    ##################################################
    # Compiler
    ##################################################

    def compile(self, s: str, logging=False) -> X86Program:
        compiler_passes = {
            'shrink': self.shrink,
            'remove complex operands': self.remove_complex_operands,
            'explicate control': self.explicate_control,
            'select instructions': self.select_instructions,
            'assign homes': self.assign_homes,
            'patch instructions': self.patch_instructions,
            'prelude & conclusion': self.prelude_and_conclusion,
        }

        current_program = parse(s)

        if logging == True:
            print()
            print('==================================================')
            print(' Input program')
            print('==================================================')
            print()
            print(s)

        for pass_name, pass_fn in compiler_passes.items():
            current_program = pass_fn(current_program)

            if logging == True:
                print()
                print('==================================================')
                print(f' Output of pass: {pass_name}')
                print('==================================================')
                print()
                print(current_program)

        return current_program


##################################################
# Execute
##################################################

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python compiler.py <source filename>')
    else:
        file_name = sys.argv[1]
        with open(file_name) as f:
            print(f'Compiling program {file_name}...')

            try:
                program = f.read()
                compiler = Compiler()
                x86_program = compiler.compile(program, logging=True)

                with open(file_name + '.s', 'w') as output_file:
                    output_file.write(str(x86_program))

            except:
                print(
                    'Error during compilation! **************************************************'
                )
                import traceback

                traceback.print_exception(*sys.exc_info())
