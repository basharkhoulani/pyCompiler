from tokens import *
import lexer
import ast
from error import ParserError
import collections


class Parser:
    def __init__(self, input: list[Token]) -> None:
        self.__input__ = input
        self.__current_pos__ = 0
        self.__current_token__ = self.__input__[self.__current_pos__]
        self.__deque__ = collections.deque()

    def __read_token__(self):
        self.__current_pos__ += 1
        self.__current_token__ = self.__input__[self.__current_pos__]

    def __reset_pos__(self, pos: int):
        self.__current_pos__ = pos
        self.__current_token__ = self.__input__[self.__current_pos__]

    def __expect__(self, token_type: str) -> bool:
        if self.__current_token__.type == token_type:
            self.__read_token__()
            return True
        else:
            return False

    def __fail__(self, pos: int, rule: str) -> None:
        failed_token = self.__input__[pos]
        raise ParserError(failed_token.type, pos, rule)

    # Grammatik Regeln
    # expr -> term ADD expr | term
    # term -> exponent MULT term | exponent
    # exponent -> factor EXP exponent | factor
    # factor -> USUB subt | subt
    # subt -> (NUM, <value>) | (FLOAT, <value>) | LPAR expr RPAR

    # E -> T+E | T
    # T -> P*T | P
    # P -> F**P | F
    # F -> -S | S
    # S -> (E) | (NUM, <value>) | (FLOAT, <value>)

    def expr(self):
        self.__deque__.clear()
        posBegin = self.__current_pos__
        term = self.term()
        self.__deque__.append(term)
        posAfterTerm = self.__current_pos__
        if term:
            if self.__expect__(ADD):
                expr = self.expr()
                self.__deque__.append(expr)
                if expr:
                    self.__deque__.clear()
                    return ast.BinOp(term, ast.Add(), expr)
                self.__deque__.pop()
        self.__reset_pos__(posAfterTerm)
        term = self.__deque__.pop()
        if term:
            self.__deque__.clear()
            return term
        self.__fail__(posBegin, "expr")

    def term(self):
        self.__deque__.clear()
        posBegin = self.__current_pos__
        expo = self.exponent()
        self.__deque__.append(expo)
        posAfterExpo = self.__current_pos__
        if expo:
            if self.__expect__(MUL):
                term = self.term()
                self.__deque__.append(term)
                if term:
                    self.__deque__.clear()
                    return ast.BinOp(expo, ast.Mult(), term)
                self.__deque__.pop()
        self.__reset_pos__(posAfterExpo)
        expo = self.__deque__.pop()
        if expo:
            self.__deque__.clear()
            return expo
        self.__fail__(posBegin, "term")

    def exponent(self):
        self.__deque__.clear()
        posBegin = self.__current_pos__
        factor = self.factor()
        self.__deque__.append(factor)
        posAfterFactor = self.__current_pos__
        if factor:
            if self.__expect__(EXP):
                exponent = self.exponent()
                self.__deque__.append(exponent)
                if exponent:
                    self.__deque__.clear()
                    return ast.BinOp(factor, ast.Pow(), exponent)
                self.__deque__.pop()
        self.__reset_pos__(posAfterFactor)
        factor = self.__deque__.pop()
        if factor:
            self.__deque__.clear()
            return factor
        self.__fail__(posBegin, "exponent")

    def factor(self):
        self.__deque__.clear()
        posBegin = self.__current_pos__
        posAfterSubt = self.__current_pos__
        if self.__expect__(USUB):
            subt = self.subt()
            self.__deque__.append(subt)
            posAfterSubt = self.__current_pos__
            if subt:
                self.__deque__.clear()
                return ast.UnaryOp(ast.USub(), subt)
        self.__reset_pos__(posAfterSubt)
        if len(self.__deque__) > 0:
            subt = self.__deque__.pop()
        else:
            subt = self.subt()
        if subt:
            self.__deque__.clear()
            return subt
        self.__fail__(posBegin, "factor")

    def subt(self):
        pos = self.__current_pos__
        if self.__expect__(LPAREN):
            expression = self.expr()
            if expression:
                if self.__expect__(RPAREN):
                    return expression
        self.__reset_pos__(pos)
        if self.__expect__(NUM) or self.__expect__(FLOAT):
            return ast.Constant(self.__input__[self.__current_pos__ - 1].value)
        self.__reset_pos__(pos)

    def parse(self):
        expression = self.expr()
        if expression and self.__input__[self.__current_pos__].type == EOF:
            return expression
        self.__fail__(self.__current_pos__, "parse")


if __name__ == "__main__":
    inputexpr = lexer.Lexer("-(-(1 + 2) * 3 ** (-(-4) + 5)) + 23 **23 * 23").lex()
    parser = Parser(inputexpr)
    tree = parser.parse()
    print(ast.dump(tree, indent=4))
