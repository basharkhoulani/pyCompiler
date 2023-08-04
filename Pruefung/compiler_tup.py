from ast import *
from x86_ast import *
import x86_ast
from graph import *
from utils import *
from dataflow_analysis import analyze_dataflow
import copy
from type_check_Ltup import TypeCheckLtup
from type_check_Ctup import TypeCheckCtup

Binding = tuple[Name, expr]
Temporaries = list[Binding]
get_fresh_tmp = lambda: generate_name('tmp')

registers_for_coloring = [
    Reg('rcx'),
    Reg('rdx'),
    Reg('rsi'),
    Reg('r8'),
    Reg('r9'),
    Reg('r10')
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
        case Is():
            return 'e'

label = lambda v: v.id if isinstance(v, Reg) else str(v)

caller_saved_registers: set[location] = set(
    [
        Reg('rax'),
        Reg('rcx'),
        Reg('rdx'),
        Reg('rsi'),
        Reg('rdi'),
        Reg('r8'),
        Reg('r9'),
        Reg('r10'),
        Reg('r11'),
    ]
)

callee_saved_registers: set[location] = set(
    [Reg('rsp'), Reg('rbp'), Reg('rbx'), Reg('r12'), Reg('r13'), Reg('r14'), Reg('r15')]
)

def get_loc_from_arg(a: arg) -> set[location]:
    match a:
        case Reg(_):
            return set([a])
        case Variable(_):
            return set([a])
        case ByteReg(_):
            return set([a])
        case _:
            return set([])

class Compiler:
    
    env = {}
    stack_size = 0
    root_stack_size = 0

    def tmps_to_stmts(self, tmps: Temporaries) -> list[stmt]:
        result = []
        for tmp in tmps:
            lhs, rhs = tmp
            result.append(Assign([lhs], rhs))
        return result

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
            case Call(Name('len'), [expr]):
                return Call(Name('len'), [self.shrink_exp(expr)])
            case Subscript(expr, Constant(index), ls):
                return Subscript(self.shrink_exp(expr), Constant(index), ls)
            case Tuple(exprs, Load()):
                return Tuple([self.shrink_exp(expr) for expr in exprs], Load())
            case Expr(expr):
                return Expr(self.shrink_exp(expr))
            case GlobalValue(_):
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
            case Collect(_):
                return s
            case _:
                raise Exception('unhandled case in shrink_stmt:' + repr(s))

    def shrink(self, p: Module) -> Module:
        new_body = []
        for stm in p.body:
            new_body.append(self.shrink_stmt(stm))
        return Module(new_body)

    ###########################################################################
    # Expose Allocation
    ###########################################################################
    
    def expose_allocation_expr(self, e: expr) -> expr:
        match e:
            case UnaryOp(op, expr):
                return UnaryOp(op, self.expose_allocation_expr(expr))
            case BinOp(e1, op, e2):
                return BinOp(self.expose_allocation_expr(e1), op, self.expose_allocation_expr(e2))
            case BoolOp(op, [e1, e2]):
                return BoolOp(op, [self.expose_allocation_expr(e1), self.expose_allocation_expr(e2)])
            case Compare(e1, [cmp], [e2]):
                return Compare(self.expose_allocation_expr(e1), [cmp], [self.expose_allocation_expr(e2)])
            case IfExp(e1, e2, e3):
                return IfExp(self.expose_allocation_expr(e1), self.expose_allocation_expr(e2), self.expose_allocation_expr(e3))
            case Tuple(exprs, Load()):
                nexprs = [self.expose_allocation_expr(expr) for expr in exprs]
                
                # 1: Assign expresssions to variables for tuple
                assignments: list[stmt] = []
                for nexpr in nexprs:
                    assignments.append(Assign([Name(generate_name('init'))], nexpr))
                    
                # 2: Check for space
                test = Compare(BinOp(GlobalValue('free_ptr'), Add(), Constant(len(nexprs) * 8 + 8)), [Lt()], [GlobalValue('fromspace_end')])
                thn = []
                els = [Collect(len(nexprs) * 8 + 8)]
                allocate = self.shrink_stmt(If(test, thn, els))
                
                # 3: Allocate
                tup_name = Name(generate_name('tup'))
                tup = Assign([tup_name], Allocate(len(nexprs), e.has_type))
                
                # 4: Assign tuple to pointer
                tup_assigns: list[stmt] = []
                index = 0
                for assignment in assignments:
                    tup_assigns.append(Assign([Subscript(tup_name, Constant(index), Store())], assignment.targets[0]))
                    index += 1
                    
                result = Begin(assignments + [allocate, tup] + tup_assigns, tup_name)
                return result
            case _:
                return e
            
    def expose_allocation_stmts(self, stmts: list[stmt]) -> list[stmt]:
        return [self.expose_allocation_stmt(s) for s in stmts]

    def expose_allocation_stmt(self, s: stmt) -> stmt:
        match s:
            case Expr(Call(Name('print'), [expr])):
                return Expr(Call(Name('print'), [self.expose_allocation_expr(expr)]))
            case Expr(expr):
                return Expr(self.expose_allocation_expr(expr))
            case Assign([Name(var)], expr):
                return Assign([Name(var)], self.expose_allocation_expr(expr))
            case Assign([Subscript(expr, Constant(index), Store())], expr2):
                return Assign([Subscript(self.expose_allocation_expr(expr), Constant(index), Store())], 
                              self.expose_allocation_expr(expr2))
            case If(test, thn, els):
                return If(
                    self.expose_allocation_expr(test),
                    self.expose_allocation_stmts(thn),
                    self.expose_allocation_stmts(els))
            case While(test, stmts, []):
                nstmts = [self.expose_allocation_stmt(s) for s in stmts]
                return While(self.expose_allocation_expr(test), nstmts, [])
            case _:
               raise Exception('unhandled case in expose_allocation_stmt:' + repr(s))
            

    def expose_allocation(self, p: Module) -> Module:
        TypeCheckLtup().type_check(p)
        new_body = []
        for stm in p.body:
            new_body.append(self.expose_allocation_stmt(stm))
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
            case UnaryOp(op, e1):
                atm, tmps = self.rco_exp(e1, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmps + [(Name(fresh_tmp), UnaryOp(op, atm))],
                    )
                return (UnaryOp(op, atm), tmps)
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
            case Begin(stmts, ex):
                nstmts = []
                for stmt in stmts:
                    for nstmt in self.rco_stmt(stmt):
                        nstmts.append(nstmt)
                return (Begin(nstmts, ex), [])
            case Subscript(e1, e2, ls):
                atm1, tmp1 = self.rco_exp(e1, True)
                atm2, tmp2 = self.rco_exp(e2, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmp1 + tmp2 + [(Name(fresh_tmp), Subscript(atm1, atm2, ls))],
                    )
                return (Subscript(atm1, atm2, ls), tmp1 + tmp2)
            case Call(Name('len'), [e]):
                atm1, tmp1 = self.rco_exp(e, True)
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        tmp1 + [(Name(fresh_tmp), Call(Name('len'), [atm1]))],
                    )
                return (Call(Name('len'), [atm1]), tmp1)
            case Allocate(n, t):
                if need_atomic:
                    fresh_tmp = get_fresh_tmp()
                    return (
                        Name(fresh_tmp),
                        [(Name(fresh_tmp), Allocate(n, t))],
                    )
                return (e, [])
            case GlobalValue(v):
                return (e, [])
            case Expr(expr):
                return self.rco_exp(expr, need_atomic)
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
            case Collect(n):
                return [s]
            case Assign([Subscript(e1, e2, Store())], e3):
                atm1, tmps1 = self.rco_exp(e1, True)
                atm2, tmps2 = self.rco_exp(e2, True)
                atm3, tmps3 = self.rco_exp(e3, True)
                
                result = self.tmps_to_stmts(tmps1 + tmps2 + tmps3)
                return result + [Assign([Subscript(atm1, atm2, Store())], atm3)]
            case _:
                raise Exception('unhandled case in rco_stmt ' + repr(s))

    def remove_complex_operands(self, p: Module) -> Module:
        match p:
            case Module(body):
                new_body = []
                for stm in body:
                    new_body += self.rco_stmt(stm)
                return Module(new_body)

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
                new_body = self.explicate_effect(result, cont, basic_blocks) + [cont]
                for s in reversed(body):
                    new_body = self.explicate_stmt(s, new_body, basic_blocks)
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
            case Collect(n):
                return [Collect(n)] + cont
            case _:
                raise Exception('unhandled case in explicate_stmt: ' + repr(s))

    def explicate_control(self, p: Module) -> CProgram:
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
            case Constant(n):
                return Immediate(n)
            case Name(v):
                return Variable(v)
            case GlobalValue(v):
                return x86_ast.Global(v)
            case [arg]:
                return self.select_arg(arg)
            case _:
                raise Exception('unhandled case in select_arg: ' + repr(e))

    def select_assign(self, s: stmt) -> list[Instr]:
        result = []
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
            case Assign([Name(var)], BinOp(atm1, Add(), atm2)):
                arg1 = self.select_arg(atm1)
                arg2 = self.select_arg(atm2)
                lhs = Variable(var)
                if arg1 == lhs:
                    result.append(Instr('addq', [arg2, lhs]))
                elif arg2 == lhs:
                    result.append(Instr('addq', [arg1, lhs]))
                else:
                    result.append(Instr('movq', [arg1, lhs]))
                    result.append(Instr('addq', [arg2, lhs]))
            case Assign([Name(var)], BinOp(atm1, Sub(), atm2)):
                arg1 = self.select_arg(atm1)
                arg2 = self.select_arg(atm2)
                lhs = Variable(var)
                if arg1 == lhs:
                    result.append(Instr('subq', [arg2, lhs]))
                elif arg2 == lhs:
                    result.append(Instr('negq', [lhs]))
                    result.append(Instr('addq', [arg1, lhs]))
                else:
                    result.append(Instr('movq', [arg1, lhs]))
                    result.append(Instr('subq', [arg2, lhs]))
            case Assign([Name(var)], UnaryOp(USub(), atm)):
                arg = self.select_arg(atm)
                result.append(Instr('movq', [arg, Variable(var)]))
                result.append(Instr('negq', [Variable(var)]))
            case Assign([Name(var)], Call(Name('input_int'), [])):
                result.append(Callq(label_name('read_int'), 0))
                result.append(Instr('movq', [Reg('rax'), Variable(var)]))
            case Assign([Name(var)], Call(Name('len'), [atm])):
                bitMask = 0b1111110 # bit mask for vector length
                return [
                    Instr('movq', [self.select_arg(atm), Reg('r11')]),
                    Instr('movq', [Deref('r11', 0), Reg('r11')]),
                    Instr('andq', [Immediate(bitMask), Reg('r11')]),
                    Instr('sarq', [Immediate(1), Reg('r11')]),
                    Instr('movq', [Reg('r11'), self.select_arg(Name(var))])
                ]
            case Assign([Name(var)], Allocate(n, t)):
                unused = 0b000000   #  6 bits unused
                mask   = 0          # 51 bits for mask (1 ptr, 0 data)
                length = n          #  6 bits for length
                fwd    = 0b0        #  1 bit for forwarding (GC)
                
                index = 0
                for type in t.types:
                    match type:
                        case TupleType(_):
                            mask |= (1 << index)
                        # unnessecary
                        # case _:
                        #     mask |= (0 << index)
                    index += 1
                            
                tag = unused
                tag <<= 51
                tag |= mask
                tag <<= 6
                tag |= length
                tag <<= 1
                tag |= fwd
                            
                return [
                    Instr('movq', [x86_ast.Global('free_ptr'), Reg('r11')]),
                    Instr('addq', [Immediate(8 * (n + 1)), x86_ast.Global('free_ptr')]),
                    Instr('movq', [Immediate(tag), Deref('r11', 0)]),
                    Instr('movq', [Reg('r11'), self.select_arg(Name(var))]),
                ]
            case Assign([Subscript(atm1, Constant(n), Store())], Call(Name('len'), [atm2])):
                bitMask = 0b1111110 # bit mask for vector length
                return [
                    Instr('movq', [self.select_arg(atm2), Reg('r11')]),
                    Instr('movq', [Deref('r11', 0), Reg('r11')]),
                    Instr('andq', [Immediate(bitMask), Reg('r11')]),
                    Instr('sarq', [Immediate(1), Reg('r11')]),
                    Instr('movq', [self.select_arg(atm1), Reg('r12')]),
                    Instr('movq', [Reg('r11'), Deref('r12', 8 * (n + 1))]),
                ]
            case Assign([Subscript(atm1, Constant(n1), Store())], Subscript(atm2, Constant(n2), Load())):
                arg1 = self.select_arg(atm1)
                arg2 = self.select_arg(atm2)
                result.append(Instr('movq', [arg2, Reg('r11')]))
                result.append(Instr('movq', [Deref('r11', 8 * (n2+1)), Reg('r12')]))
                result.append(Instr('movq', [arg1, Reg('r11')]))
                result.append(Instr('movq', [Reg('r12'), Deref('r11', 8 * (n1+1))]))
            case Assign(atm1, Subscript(atm2, Constant(n), Load())):
                arg1 = self.select_arg(atm1)
                arg2 = self.select_arg(atm2)
                result.append(Instr('movq', [arg2, Reg('r11')]))
                result.append(Instr('movq', [Deref('r11', 8 * (n+1)), arg1]))
            case Assign([Subscript(atm1, Constant(n), Store())], atm2):
                arg1 = self.select_arg(atm1)
                arg2 = self.select_arg(atm2)
                result.append(Instr('movq', [arg1, Reg('r11')]))
                result.append(Instr('movq', [arg2, Deref('r11', 8 * (n+1))]))
            case Assign([Name(var)], atm):
                arg = self.select_arg(atm)
                result.append(Instr('movq', [arg, Variable(var)]))                
            case _:
                raise Exception('unhandled case in select_assign: ' + repr(s))
        return result

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
            case Assign(_,_):
                return self.select_assign(s)
            case Expr(Call(Name('print'), [atm])):
                arg = self.select_arg(atm)
                return [
                    Instr('movq', [arg, Reg('rdi')]),
                    Callq(label_name('print_int'), 1),
                ]
            case Expr(Call(Name('input_int'), [])):
                return [Callq(label_name('read_int'), 0)]
            case Collect(n):
                return [
                    Instr('movq', [Reg('r15'), Reg('rdi')]),
                    Instr('movq', [Immediate(n), Reg('rsi')]),
                    Callq('collect', 1),
                ]
            case _:
                raise Exception('unhandled case in select_stmt: ' + repr(s))

    def select_instructions(self, p: Module) -> X86Program:
        TypeCheckCtup().type_check(p)
        self.env = p.var_types
        
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
    # Allocate Registers
    ############################################################################

    # select spill candidate by most neighbors
    def find_spill(self, graph: UndirectedAdjList) -> location:
        most_neighbors = list(graph.vertices())[0]
        for v in graph.vertices():
            if len(graph.adjacent(v)) > len(graph.adjacent(most_neighbors)):
                most_neighbors = v

        return v

    def color_graph(
        self, graph: UndirectedAdjList, colors: set[location]
    ) -> dict[Variable, arg]:
        coloring = {}

        orig_graph = copy.deepcopy(graph)

        k = len(colors)
        stack = []

        # for all vertices in the graph, select a vertex and remove it and put it on stack
        while len(graph.vertices()) > 0:
            # get vertex v with neighbors(v) < k
            v = next(
                filter(lambda v: len(graph.adjacent(v)) < k, graph.vertices()), None
            )

            # could not find vertex with neighbors(v) < k
            if v is None:
                potential_spill = self.find_spill(graph)
                graph.remove_vertex(potential_spill)
                stack.append(potential_spill)
            # found vertex
            else:
                graph.remove_vertex(v)
                stack.append(v)

        # for all vertices on stack, assign a color to them if possible
        while len(stack) > 0:
            d = stack.pop()

            if isinstance(d, Reg):
                continue

            neighbors = orig_graph.adjacent(d)

            # find available color not assigned to neighbors(d)
            color = next(
                filter(
                    lambda c: not c in [coloring.get(u, None) for u in neighbors],
                    colors,
                ),
                None,
            )

            # if colorable, assign the color
            if color != None:
                coloring[d] = color

        return coloring

    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes_arg(self, a: arg, home: dict[Variable, arg]) -> arg:
        match a:
            case Variable(_):
                if a not in home:
                    self.stack_size += 8
                    home[a] = Deref('rbp', -self.stack_size)
                return home[a]
            case _:
                return a

    def assign_homes_instr(self, i: instr, home: dict[Variable, arg]) -> list[instr]:
        match i:
            case Instr(op, [arg1, arg2]):
                return [Instr(
                    op,
                    [
                        self.assign_homes_arg(arg1, home),
                        self.assign_homes_arg(arg2, home),
                    ],
                )]
            case Instr(op, [arg1]):
                return [Instr(op, [self.assign_homes_arg(arg1, home)])]
            case Callq('read_int', 0) | Callq('print_int', 1):
                return [i]
            case Callq('collect', 1):
                movRootStack = []
                
                self.root_stack_size = 0
                for var in home:
                    if isinstance(var, Variable):
                        varName = var.id
                        varType = self.env[varName]
                        if isinstance(varType, TupleType):
                            movRootStack += [Instr('movq', [home[var], Deref('r15', -8 * self.root_stack_size)])]
                            self.root_stack_size += 1
                
                return movRootStack + [i];
            case _:
                return [i]

    def assign_homes_instrs(self, ss: list[instr], home: dict[Variable, arg]) -> list[instr]:
        result = []
        for i in ss:
            result += self.assign_homes_instr(i, home)
        return result

    def assign_homes(self, p: X86Program) -> X86Program:
        # for liveness analysis there needs to be a dummy block for conclusion
        p.body['conclusion'] = []

        live_blocks = self.uncover_live_blocks(p.body)
        rig = self.build_interference(p, live_blocks)
        home = self.color_graph(rig, registers_for_coloring)

        new_body = {}
        for block_id, instrs in p.body.items():
            new_body[block_id] = self.assign_homes_instrs(instrs, home)

        return X86Program(new_body)

    ###########################################################################
    # Patch Instructions
    ###########################################################################

    def save(self, registers: list[Reg]) -> list[Instr]:
        self.stack_size = max(self.stack_size, self.stack_before + 8 * (len(registers) + 1))
        result: list[Instr] = []
        index = 1
        # save all variables onto the stack
        for reg in registers:
            # except for rax and rdi
            if isinstance(reg, Reg) and reg in caller_saved_registers and reg in registers_for_coloring:
                result.append(Instr('movq', [reg, Deref('rbp', -(self.stack_before + 8 * index))]))
                index += 1
        return result

    def restore(self, registers: list[Reg]) -> list[Instr]:
        self.stack_size = max(self.stack_size, self.stack_before + 8 * (len(registers) + 1))
        result: list[Instr] = []
        index = 1
        # restore all variables from the stack
        for reg in registers:
            # except for rax and rdi
            if isinstance(reg, Reg) and reg in caller_saved_registers and reg in registers_for_coloring:
                result.append(Instr('movq', [Deref('rbp', -(self.stack_before + 8 * index)), reg]))
                index += 1
        return result

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
            case Instr('movq', [arg1, arg2]) if arg1 == arg2:
                return []
            case Instr(op, [Deref(reg, offset), Deref(reg2, offset2)]):
                return [
                    Instr('movq', [Deref(reg, offset), Reg('rax')]),
                    Instr(op, [Reg('rax'), Deref(reg2, offset2)]),
                ]
            case Callq(name, n):
                return self.save(caller_saved_registers) + [i] + self.restore(caller_saved_registers)
            case _:
                return [i]

    def patch_instrs(self, instrs: list[instr]) -> list[instr]:
        result = []
        for i in instrs:
            result += self.patch_instr(i)
        return result

    def patch_instructions(self, p: X86Program) -> X86Program:
        new_body = {}
        self.stack_before = self.stack_size

        for block_id, block_items in p.body.items():
            new_body[block_id] = self.patch_instrs(block_items)

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
            
        prelude += [
            Instr('movq', [Immediate(16384), Reg('rdi')]),
            Instr('movq', [Immediate(16384), Reg('rsi')]),
            Callq('initialize', 0),
            Instr('movq', [x86_ast.Global('rootstack_begin'), Reg('r15')]),
        ]
        
        for i in range(self.root_stack_size):
            prelude.append(Instr('movq', [Immediate(0), Deref('r15', 8 * i)]))
        
        if self.root_stack_size > 0:
            prelude += [
                Instr('addq', [Immediate(self.root_stack_size * 8), Reg('r15')])
            ]

        p.body['main'] = prelude + [Jump('start')]
        conclusion = [Instr('popq', [Reg('rbp')]), Instr('retq', [])]

        if self.root_stack_size > 0:
            conclusion.insert(
                0, Instr('subq', [Immediate(self.root_stack_size * 8), Reg('r15')])
            )

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
            'expose allocation': self.expose_allocation,
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
