from tokens import *
import lexer


class Parser:
    __input__: list[Token]
    __current_pos__: int
    __current_token__: Token

    # Hilfsfunktionen

    def __read_tok__(self):
        self.__current_pos__ += 1
        self.__current_token__ = self.__input__[self.__current_pos__]

    def __reset_pos__(self, pos: int):
        self.__current_pos__ = pos
        self.__current_token__ = self.__input__[self.__current_pos__]

    def __expect__(self, token_type: str) -> bool:
        if self.__current_token__.type == token_type:
            self.__read_tok__()
            return True
        else:
            return False

    def parse(self, tokens: list[Token]) -> bool:
        self.__input__ = tokens
        self.__current_pos__ = 0
        self.__current_token__ = self.__input__[self.__current_pos__]
        if self.expr() and self.__input__[self.__current_pos__].type == EOF:
            return True
        else:
            return False

    # Grammatikregeln

    def expr(self):
        return self.pow()

    def pow(self):
        pos = self.__current_pos__

        if self.mul() and self.__expect__(MUL) and self.__expect__(MUL) and self.expr():
            return True
        self.__reset_pos__(pos)

        if self.mul():
            return True
        self.__reset_pos__(pos)

        return False

    def mul(self):
        pos = self.__current_pos__

        if self.add() and self.__expect__(MUL) and self.expr():
            return True
        self.__reset_pos__(pos)

        if self.add():
            return True
        self.__reset_pos__(pos)

        return False

    def add(self):
        pos = self.__current_pos__
        if self.term() and self.__expect__(ADD) and self.add():
            return True
        self.__reset_pos__(pos)

        if self.term():
            return True
        self.__reset_pos__(pos)

        return False

    def term(self):
        pos = self.__current_pos__
        if self.__expect__(USUB) and self.factor():
            return True
        self.__reset_pos__(pos)

        if self.factor():
            return True
        self.__reset_pos__(pos)

        return False

    def factor(self):
        pos = self.__current_pos__
        if self.__expect__(NUM) or self.__expect__(FLOAT):
            return True
        self.__reset_pos__(pos)

        if self.__expect__(LPAREN) and self.expr() and self.__expect__(RPAREN):
            return True
        self.__reset_pos__(pos)

        return False


# Parser starten

if __name__ == '__main__':
    parser = Parser()
    lexer = lexer.Lexer()
    token_list = lexer.lex("(-23 +16 )*- 4.23 ** -(2**2)")
    is_correct = parser.parse(token_list)
    print(token_list)
    print(is_correct)
