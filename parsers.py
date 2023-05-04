from tokens import *
import lexer
from ParserError import ParserError
import ExprTree as ast

class Parsers:
    def __init__(self,input: list[Token]) -> None:
        self.input = input
        self.__current_pos__ = 0
        self.__current_token__ = self.input[self.__current_pos__]
        self.ruleStack = ["Error"]

        #layout : (startPos, rule, sucess, EndPos, AST)
        self.memoryDict = (0, "error", False, 0, ast.Expr())

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
        pos = self.__current_pos__

        #do we already know the result?
        if self.memoryDict[0] == self.__current_pos__ and self.memoryDict[1] == "expr":

            if not self.memoryDict[2]:
                return False, None

            self.__reset_pos__(self.memoryDict[3])
            return True, self.memoryDict[4]

        #expr -> term + expr
        endB, expr = self.binaryOperator(self.term, ADD, self.expr, ast.Add)
        if endB:
            self.memoryDict = (pos, "expr", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        #expr -> term
        endB, expr = self.changeTerminal(self.term)
        if endB:
            self.memoryDict = (pos, "expr", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        self.memoryDict = (pos, "expr", False, self.__current_pos__, None)
        return False, None
    
    def term(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("term")
        pos = self.__current_pos__

        #do we already know the result?
        if self.memoryDict[0] == self.__current_pos__ and self.memoryDict[1] == "term":

            if not self.memoryDict[2]:
                return False, None

            self.__reset_pos__(self.memoryDict[3])
            return True, self.memoryDict[4]

        #term -> potential * term
        endB, expr = self.binaryOperator(self.potential, MUL, self.term, ast.Mult)
        if endB:
            self.memoryDict = (pos, "term", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        #term -> potential
        endB, expr = self.changeTerminal(self.potential)
        if endB:
            self.memoryDict = (pos, "term", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        self.memoryDict = (pos, "term", False, self.__current_pos__, None)
        return False, None

    def potential(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("potential")
        pos = self.__current_pos__

        #do we already know the result?
        if self.memoryDict[0] == self.__current_pos__ and self.memoryDict[1] == "potential":
 
            if not self.memoryDict[2]:
                return False, None
           
            self.__reset_pos__(self.memoryDict[3])
            return True, self.memoryDict[4]

        #potential -> factor**potential
        endB, expr = self.binaryOperator3(self.factor, MUL, MUL, self.potential, ast.Potenz)
        if endB:
            self.memoryDict = (pos, "potential", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        #potential -> factor
        endB, expr = self.changeTerminal(self.factor)
        if endB:
            self.memoryDict = (pos, "potential", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        self.memoryDict = (pos, "potential", False, self.__current_pos__, None)
        return False, None
    
    def factor(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("factor")
        pos = self.__current_pos__

        #do we already know the result?
        if self.memoryDict[0] == self.__current_pos__ and self.memoryDict[1] == "factor":

            if not self.memoryDict[2]:
                return False, None

            self.__reset_pos__(self.memoryDict[3])
            return True, self.memoryDict[4]

        #factor -> -subt
        endB, expr = self.unaryOperator(USUB, self.subt, ast.Usub)
        if endB:
            self.memoryDict = (pos, "factor", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        #factor -> subt
        endB, expr = self.changeTerminal(self.subt)
        if endB:
            self.memoryDict = (pos, "factor", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        self.memoryDict = (pos, "factor", False, self.__current_pos__, None)
        return False, None

    def subt(self) -> (tuple[False, None] | tuple[True, ast.Expr]):
        self.ruleStack.append("subt")

        #do we already know the result?
        if self.memoryDict[0] == self.__current_pos__ and self.memoryDict[1] == "subt":
 
            if not self.memoryDict[2]:
                return False, None
           
            self.__reset_pos__(self.memoryDict[3])
            return True, self.memoryDict[4]

        #subt -> NUM
        pos = self.__current_pos__
        w = self.__current_token__.value
        if self.__expect__(NUM):
            self.ruleStack.pop()
            self.memoryDict = (pos, "subt", True, self.__current_pos__, ast.Num(w))
            return True, ast.Num(w)
        self.__reset_pos__(pos)

        #subt -> FLOAT
        w = self.__current_token__.value
        if self.__expect__(FLOAT):
            self.ruleStack.pop()
            self.memoryDict = (pos, "subt", True, self.__current_pos__, ast.Float(w))
            return True, ast.Float(w)
        self.__reset_pos__(pos)

        #subt -> (expr)
        endB, expr = self.klammerExpr(LPAREN, self.expr, RPAREN, self.passAST)
        if endB:
            self.memoryDict = (pos, "subt", True, self.__current_pos__, expr)
            self.ruleStack.pop()
            return True, expr

        self.memoryDict = (pos, "subt", False, self.__current_pos__, None)
        return False, None

    
    # Parser starten

    def parse(self):
        b, expr = self.expr()
        if b and self.input[self.__current_pos__].type == EOF:
            return expr
        else:
            raise ParserError(self.__current_token__, self.__current_pos__ + 1, self.ruleStack[-1])
         
        


if __name__ == '__main__':
    token_list = lexer.Lexer('3+-3+3**+3**3').lex()
    print(token_list)
    print(Parsers(token_list).parse())
