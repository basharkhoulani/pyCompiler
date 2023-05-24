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
        # YOUR CODE HERE
        pass

    def select_stmt(self, s: stmt) -> list[instr]:
        pass

    def select_instructions(self, p: Module) -> X86Program:
        out = []

        for i in p.body:
            out_instr = self.select_stmt(i)

        return X86Program(out)


    ############################################################################
    # Assign Homes
    ############################################################################

    def assign_homes_arg(self, a: arg, home: dict[Variable, arg]) -> arg:
        # YOUR CODE HERE
        pass

    def assign_homes_instr(self, i: instr,
                           home: dict[Variable, arg]) -> instr:
        # YOUR CODE HERE
        pass

    def assign_homes_instrs(self, s: list[instr],
                            home: dict[Variable, arg]) -> list[instr]:
        # YOUR CODE HERE
        pass

    def assign_homes(self, p: X86Program) -> X86Program:
         # YOUR CODE HERE
         pass

    ############################################################################
    # Patch Instructions
    ############################################################################

    def patch_instr(self, i: instr) -> list[instr]:
        # YOUR CODE HERE
        pass

    def patch_instrs(self, s: list[instr]) -> list[instr]:
        # YOUR CODE HERE
        pass

    def patch_instructions(self, p: X86Program) -> X86Program:
         # YOUR CODE HERE
         pass

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
