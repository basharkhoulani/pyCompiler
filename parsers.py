from tokens import *
import lexer
import ast


class Parser:
    def __init__(self, input: list[Token]) -> None:
        self.input = input
        self.__current_pos__ = 0
        self.__current_token__ = self.input[self.__current_pos__]

    def __read_token__(self):
        self.__current_pos__ += 1
        self.__current_token__ = self.input[self.__current_pos__]

    def __reset_pos__(self, pos: int):
        self.__current_pos__ = pos
        self.__current_token__ = self.input[self.__current_pos__]

    def __expect__(self, token_type: str) -> bool:
        if self.__current_token__.type == token_type:
            self.__read_token__()
            return True
        else:
            return False

    # Grammatik Regeln
    # expr -> term ADD expr | term
    # term -> exponent MULT term | exponent
    # exponent -> factor EXP exponent | factor
    # factor -> USUB subt | subt
    # subt -> (NUM, <value>) | LPAR expr RPAR

    def expr(self):
        pos = self.__current_pos__
        if self.term() and self.__expect__(ADD) and self.expr():
            return ast.Add()
        self.__reset_pos__(pos)
        if self.term():
            return True
        return False

    def term(self):
        pos = self.__current_pos__
        if self.exponent() and self.__expect__(MUL) and self.term():
            return ast.Mult()
        self.__reset_pos__(pos)
        if self.exponent():
            return True

    def exponent(self):
        pos = self.__current_pos__
        if self.factor() and self.__expect__(EXP) and self.exponent():
            return ast.Pow()
        self.__reset_pos__(pos)
        if self.factor():
            return True

    def factor(self):
        pos = self.__current_pos__
        if self.__expect__(USUB) and self.subt():
            return ast.USub()
        self.__reset_pos__(pos)
        if self.subt():
            return True

    def subt(self):
        pos = self.__current_pos__
        if self.__expect__(LPAREN) and self.expr() and self.__expect__(RPAREN):
            return True
        self.__reset_pos__(pos)
        if self.__expect__(NUM):
            return Tru
        return False

    def parse(self):
        if self.expr() and self.input[self.__current_pos__].type == EOF:
            return True
        else:
            return False


if __name__ == "__main__":
    input = lexer.Lexer("1+2**3").lex()
    parser = Parser(input)
    print(parser.parse())
