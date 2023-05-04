from tokens import *
import lexer
from ParserError import ParserError
import ExprTree as ast

class Parsers:
    def __init__(self,input: list[Token]) -> None:
        self.input = input
        self.__current_pos__ = 0
        self.__current_token__ = self.input[self.__current_pos__]
        self.ruleStack = []

    # Hilfsfunktionen
    def __read_tok__(self):
        self.__current_pos__ += 1
        self.__current_token__ = self.input[self.__current_pos__]

    def __reset_pos__(self,pos: int) -> None:
        self.__current_pos__ = pos
        self.__current_token__ = self.input[self.__current_pos__]

    def __expect__(self,token_type: str) -> bool: 
        if self.__current_token__.type == token_type:
            self.__read_tok__()
            return True
        else:
            return False
        

    #regel helfer
    
    #a -> funcA operator funcB
    def unaryOperator(self, operatorToken : str, funcA, operatorAst : ast.Expr) -> (tuple[False, None] | tuple[True, ast.Expr]):
        pos = self.__current_pos__

        lB = self.__expect__(operatorToken)
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        lB, expr1 = funcA()
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        return True, operatorAst(expr1)

    #a -> funcA operator funcB
    def binaryOperator(self, funcA, operatorToken : str, funcB, operatorAst : ast.Expr) -> (tuple[False, None] | tuple[True, ast.Expr]):
        pos = self.__current_pos__
        lB, expr1 = funcA()
        if not lB:
            self.__reset_pos__(pos)
            return False, None
        
        lB = self.__expect__(operatorToken)
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        lB, expr2 = funcB()
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        return True, operatorAst(expr1, expr2)
    
    #a -> funcA operatorA operatorB funcB
    def binaryOperator3(self, funcA, operatorTokenA : str, operatorTokenB : str, funcB, operatorAst : ast.Expr) -> (tuple[False, None] | tuple[True, ast.Expr]):
        pos = self.__current_pos__
        lB, expr1 = funcA()
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        lB = self.__expect__(operatorTokenA)
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        lB = self.__expect__(operatorTokenB)
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        lB, expr2 = funcB()
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        return True, operatorAst(expr1, expr2)
    
    #a -> opA funcA opB
    def klammerExpr(self, operatorA : str, funcA, operatorB : str, operatorAst : ast.Expr) -> (tuple[False, None] | tuple[True, ast.Expr]):
        pos = self.__current_pos__

        lB = self.__expect__(operatorA)
        if not lB:
            self.__reset_pos__(pos)
            return False, None
        
        lB, expr = funcA()
        if not lB:
            self.__reset_pos__(pos)
            return False, None

        lB = self.__expect__(operatorB)
        if not lB:
            self.__reset_pos__(pos)
            return False, None
        
        return True, operatorAst(expr)

    #a -> b 
    def changeTerminal(self, func) -> (tuple[False, None] | tuple[True, ast.Expr]):
        pos = self.__current_pos__
        b, expr = func()
        if b:
            return True, expr
        self.__reset_pos__(pos)
    
        return False, None
    
    #ast helper
    def passAST(self, a : ast.Expr) -> ast.Expr:
        return a


    # Grammatikregeln
    def expr(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("expr")

        endB, expr = self.binaryOperator(self.term, ADD, self.expr, ast.Add)
        if endB:
            self.ruleStack.pop()
            return True, expr

        endB, expr = self.changeTerminal(self.term)
        if endB:
            self.ruleStack.pop()
            return True, expr

        return False, None
    
    def term(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("term")

        endB, expr = self.binaryOperator(self.potential, MUL, self.term, ast.Mult)
        if endB:
            self.ruleStack.pop()
            return True, expr

        endB, expr = self.changeTerminal(self.potential)
        if endB:
            self.ruleStack.pop()
            return True, expr

        return False, None

    def potential(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("potential")

        endB, expr = self.binaryOperator3(self.factor, MUL, MUL, self.potential, ast.Potenz)
        if endB:
            self.ruleStack.pop()
            return True, expr

        endB, expr = self.changeTerminal(self.factor)
        if endB:
            self.ruleStack.pop()
            return True, expr

        return False, None
    
    def factor(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("factor")

        endB, expr = self.unaryOperator(USUB, self.subt, ast.Usub)
        if endB:
            self.ruleStack.pop()
            return True, expr

        endB, expr = self.changeTerminal(self.subt)
        if endB:
            self.ruleStack.pop()
            return True, expr

        return False, None

    def subt(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("subt")

        #NUM
        pos = self.__current_pos__
        w = self.__current_token__.value
        if self.__expect__(NUM):
            self.ruleStack.pop()
            return True, ast.Num(w)
        self.__reset_pos__(pos)

        #FLOAT
        w = self.__current_token__.value
        if self.__expect__(FLOAT):
            self.ruleStack.pop()
            return True, ast.Float(w)
        self.__reset_pos__(pos)

        #(expr)
        endB, expr = self.klammerExpr(LPAREN, self.expr, RPAREN, self.passAST)
        if endB:
            self.ruleStack.pop()
            return True, expr

        return False, None

    
    # Parser starten

    def parse(self):
        b, expr = self.expr()
        if b and self.input[self.__current_pos__].type == EOF:
            return expr
        else:
            #print(self.__current_pos__ + 1, self.__current_token__, self.ruleStack)
            raise ParserError(self.__current_token__, self.__current_pos__ + 1, self.ruleStack[-1])
         
        


if __name__ == '__main__':
    token_list = lexer.Lexer('3+-3+3*+*3**3').lex()
    print(token_list)
    print(Parsers(token_list).parse())
