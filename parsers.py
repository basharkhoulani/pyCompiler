from tokens import *
import lexer
import ast


class Parser:
    def __init__(self, input: list[Token]) -> None:
        self.input = input
        self.__current_pos__ = 0
        self.__current_token__ = self.input[self.__current_pos__]
        self.__tree__ = None

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
    # subt -> (NUM, <value>) | (FLOAT, <value>) | LPAR expr RPAR

    def expr(self):
        pos = self.__current_pos__
        term = self.term()
        if term:
            if self.__expect__(ADD):
                expr = self.expr()
                if expr:
                    return ast.BinOp(term, ast.Add(), expr)
        self.__reset_pos__(pos)
        term = self.term()
        if term:
            return term
        return None

    def term(self):
        pos = self.__current_pos__
        expo = self.exponent()
        if expo:
            if self.__expect__(MUL):
                term = self.term()
                if term:
                    return ast.BinOp(expo, ast.Mult(), term)
        self.__reset_pos__(pos)
        expo = self.exponent()
        if expo:
            return expo
        return None

    def exponent(self):
        pos = self.__current_pos__
        factor = self.factor()
        if factor:
            if self.__expect__(EXP):
                exponent = self.exponent()
                if exponent:
                    return ast.BinOp(factor, ast.Pow(), exponent)
        self.__reset_pos__(pos)
        factor = self.factor()
        if factor:
            return factor
        return None

    def factor(self):
        pos = self.__current_pos__
        if self.__expect__(USUB):
            subt = self.subt()
            if subt:
                return ast.UnaryOp(ast.USub(), subt)
        self.__reset_pos__(pos)
        subt = self.subt()
        if subt:
            return subt
        return None

    def subt(self):
        pos = self.__current_pos__
        if self.__expect__(LPAREN):
            expression = self.expr()
            if expression:
                if self.__expect__(RPAREN):
                    return expression
        self.__reset_pos__(pos)
        if self.__expect__(NUM) or self.__expect__(FLOAT):
            return ast.Constant(self.input[self.__current_pos__ - 1].value)
        return None

    def parse(self):
        expression = self.expr()
        if expression and self.input[self.__current_pos__].type == EOF:
            return expression
        else:
            return None


if __name__ == "__main__":
    inputexpr = lexer.Lexer("(-23 + 16 )*- 4.23 ** -(-2**-2)").lex()
    parser = Parser(inputexpr)
    tree = parser.parse()
    print(ast.dump(tree, indent=4))
