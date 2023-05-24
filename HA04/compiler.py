import ast
from ast import *
from utils import *
from x86_ast import *
import os

Binding = tuple[Name, expr]
Temporaries = list[Binding]

get_fresh_tmp = lambda: generate_name('tmp')

class Compiler:
    def __init__(self):
        self.stack_size = 0
        
    ############################################################################
    # Remove Complex Operands
    ############################################################################
    def createHelperVariable(self) -> Name:
        return Name(get_fresh_tmp())

    def rco_exp(self, e: expr, isAtomic : bool) -> tuple[expr, Temporaries]:
        
        match e:
            case Constant():
                return (e, [])
            case Name():
                return (e, [])
            case Call(func, args):
                helper_out = []
                args_out = []

                #process args
                for a in args:
                    targetExpr, helper = self.rco_exp(a, True)
                    helper_out = helper_out + helper
                    args_out.append(targetExpr)

                #atomic handling
                op = Call(func, args_out)
                if not isAtomic:
                    return (op, helper_out)

                helperVar = self.createHelperVariable()
                helper_out.append((helperVar, op))
                return (helperVar, helper_out)
            case UnaryOp(op, operand):
                #process childs
                targetExpr, helpers = self.rco_exp(operand, True)

                #build output
                op = UnaryOp(op, targetExpr)
                if not isAtomic:
                    return (op, helpers)

                helperVar = self.createHelperVariable()
                helpers.append((helperVar, op))
                return (helperVar, helpers)
            case BinOp(left, op, right):
                #process childs
                targetExprL, helpers = self.rco_exp(e.left, True)
                targetExprR, helpersR = self.rco_exp(e.right, True)

                #build output
                helpers = helpers + helpersR
                op = BinOp(targetExprL, e.op, targetExprR)
                if not isAtomic:
                    return (op, helpers)

                helperVar = self.createHelperVariable()
                helpers.append((helperVar, op))
                return (helperVar, helpers)

        raise Exception("Unkown expression" + str(type(e)))
        return (NULL, [])

    #convertes Temporaries from above to a usable stmt list
    def convert_tupel(self, a : list[Tuple]) -> list[stmt]:
        out = []

        for target, expr in a:
            out.append(Assign([target], expr))

        return out

    def rco_stmt(self, s: stmt) -> list[stmt]:

        match s:
            case Expr(value):
                targetExpr, help_instr = self.rco_exp(value, False)
                out = self.convert_tupel(help_instr)
                out.append(Expr(targetExpr))
                return out
            case Assign(targets, value):
                #assign
                targetExpr, help_instr = self.rco_exp(value, False)
                
                #fail check
                if targetExpr==None:
                    raise Exception("rco_exp needs a valid result expr")

                if len(targets) != 1 and type(targets[0]) == type(Name):
                    raise Exception("only single var assignment supported")

                #build atomare instructions
                target = targets[0]
                out = self.convert_tupel(help_instr)
                out.append(Assign([target], targetExpr))

                return out
            
            case _:
                raise Exception("unkown ast stmt")
    
        #error
        raise Exception("wrong argument, expected expr" + str(type(s)))
        return []
    
    def remove_complex_operands(self, p: Module) -> Module:
        out = []
        
        for a in p.body:
            out = out + self.rco_stmt(a)

        return Module(out)

    ############################################################################
    # Select Instructions
    ############################################################################

    def select_arg(self, e: expr) -> arg:
        match e:
            case Name(value):
                return Variable(value)
            case Constant(value):
                return Immediate(int(value))
            
            case _:
                raise Exception("unkown type for argument(x86)")
    

    def select_stmt(self, s: stmt) -> list[instr]:
        out = []
        
        match s:
            case Assign(targets, targetExpr):
                opTarget = self.select_arg(targets[0])

                match targetExpr:
                    case Name(value):
                        out.append(Instr("movq", [self.select_arg(value), opTarget]))
                    case Constant(value):
                        out.append(Instr("movq", [self.select_arg(value), opTarget]))
                    case UnaryOp(USub, expr):
                        out.append(Instr("movq", [self.select_arg(expr), opTarget]))
                        out.append(Instr("negq", [opTarget]))
                    case BinOp(left, Add, right):
                        out.append(Instr("movq", [self.select_arg(right), opTarget]))
                        out.append(Instr("addq", [self.select_arg(left), opTarget]))
                    case BinOp(left, Sub, right):
                        out.append(Instr("movq", [self.select_arg(right), opTarget]))
                        out.append(Instr("subq", [self.select_arg(left), opTarget]))
                    case BinOp(left, Mult, right):
                        out.append(Instr("movq", [self.select_arg(right), opTarget]))
                        out.append(Instr("mulq", [self.select_arg(left), opTarget]))
                    case BinOp(left, Div, right):
                        out.append(Instr("movq", [self.select_arg(right), opTarget]))
                        out.append(Instr("divq", [self.select_arg(left), opTarget]))
                    case Call(func, args):
                        if func.id != "input_int":
                            raise Exception("only input_int is allowed for an assignment")
                        
                        out.append(Callq("read_int", 0))
                        out.append(Instr("movq", [Reg("rax"), opTarget]))

                    case _:
                        raise Exception("unkown expr in instruction mapping")


            case Expr(expr):
                match expr:
                    case Call(func, args):
                        if func.id != "print":
                            raise Exception("only print is allowed for an expression")
                        
                        out.append(Instr("movq", [self.select_arg(args[0]), Reg("rdi")]))
                        out.append(Callq("print_int", 0))

        return out
                


    def select_instructions(self, p: Module) -> X86Program:
        out = []

        for i in p.body:
            out = out + self.select_stmt(i)

        return X86Program(out)


    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes_arg(self, a: arg, home: dict[Variable, arg]) -> arg:
        
        match a:
            case Variable(id):
                #do we already know this var?
                if a in home:
                    return home[a]
                
                #allocate memerory + create bookmark
                offset = -(self.stack_size + 8)
                self.stack_size = self.stack_size + 8
                out = Deref("rbp", offset)
                home[a] = out
                return out

        return a


    def assign_homes_instr(self, i: instr,
                           home: dict[Variable, arg]) -> instr:
        match i:
            case Instr(name, args):
                args_out = []

                for a in args:
                    args_out.append(self.assign_homes_arg(a, home))

                return Instr(name, args_out)

        return i


    def assign_homes_instrs(self, s: list[instr],
                            home: dict[Variable, arg]) -> list[instr]:
        out = []

        for i in s:
            out.append(self.assign_homes_instr(i, home))

        return out

    def assign_homes(self, p: X86Program) -> X86Program:
        out = []
        home = {}
        out = self.assign_homes_instrs(p.body, home)
        return X86Program(out)

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        match i:
            case Instr(name, args):

                #early skip
                if len(args)< 2:
                    return [i]
                
                if len(args) != 2:
                    raise Exception("instructions with more than two arguments are not supported")

                #second argument is also always the target => second is always a ref
                match args[0]:
                    case Deref(reg, offset):
                        helpReg = Reg("rax")
                        return [Instr("movq", [args[0], helpReg]), Instr(name, [helpReg, args[1]])]
                    case _:
                        return [i]

            case Callq(func, count):
                return [i]

    def patch_instrs(self, s: list[instr]) -> list[instr]:
        out = []

        for instr in s:
            out = out + self.patch_instr(instr)

        return out


    def patch_instructions(self, p: X86Program) -> X86Program:
        out = []
        out = self.patch_instrs(p.body)
        return X86Program(out)

    ############################################################################
    # Prelude & Conclusion
    ############################################################################

    def prelude_and_conclusion(self, p: X86Program) -> X86Program:
        new_body = []
        adjust_stack_size = self.stack_size if self.stack_size % 16 == 0 else self.stack_size + 8

        prelude = [Instr("pushq", [Reg("rbp")]), Instr("movq", [Reg("rsp"), Reg("rbp")])]
        if adjust_stack_size > 0:
            prelude.append(Instr('subq', [Immediate(adjust_stack_size), Reg('rsp')]))

        new_body.extend(prelude)
        new_body.extend(p.body)

        conclusion = [Instr('popq', [Reg('rbp')]), Instr('retq', [])]
        if adjust_stack_size > 0:
            conclusion.insert(0, Instr('addq', [Immediate(adjust_stack_size), Reg('rsp')]))

        new_body.extend(conclusion)
        return X86Program(new_body)

    ##################################################
    # Compiler
    ##################################################

    def compile(self, s: str, logging=False) -> X86Program:
        compiler_passes = {
            'remove complex operands': self.remove_complex_operands,
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
                print('Error during compilation! **************************************************')
                import traceback
                traceback.print_exception(*sys.exc_info())
