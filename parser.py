from tokens import *
from ast import *
from lexer import *
from typing import Optional


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

    def parse(self, tokens: list[Token]) -> Optional[Ast]:
        self.__input__ = tokens
        self.__current_pos__ = 0
        self.__current_token__ = self.__input__[self.__current_pos__]
        if (exp := self.expr()) and self.__input__[self.__current_pos__].type == EOF:
            return Ast(exp)
        else:
            return None

    # Grammatikregeln

    def expr(self) -> Optional[Node]:
        return self.pow()

    def pow(self) -> Optional[Node]:
        pos = self.__current_pos__

        if (lhs := self.mul()) and self.__expect__(MUL) and self.__expect__(MUL) and (rhs := self.expr()):
            return Node(AST_POW, children=[lhs, rhs])
        self.__reset_pos__(pos)

        if mul := self.mul():
            return mul
        self.__reset_pos__(pos)

        return None

    def mul(self) -> Optional[Node]:
        pos = self.__current_pos__

        if (lhs := self.add()) and self.__expect__(MUL) and (rhs := self.expr()):
            return Node(AST_MUL, children=[lhs, rhs])
        self.__reset_pos__(pos)

        if add := self.add():
            return add
        self.__reset_pos__(pos)

        return None

    def add(self) -> Optional[Node]:
        pos = self.__current_pos__
        if (lhs := self.term()) and self.__expect__(ADD) and (rhs := self.expr()):
            return Node(AST_ADD, children=[lhs, rhs])
        self.__reset_pos__(pos)

        if term := self.term():
            return term
        self.__reset_pos__(pos)

        return None

    def term(self) -> Optional[Node]:
        pos = self.__current_pos__
        if self.__expect__(USUB) and (rhs := self.factor()):
            return Node(AST_USUB, children=[rhs])
        self.__reset_pos__(pos)

        if factor := self.factor():
            return factor
        self.__reset_pos__(pos)

        return None

    def factor(self) -> Optional[Node]:
        pos = self.__current_pos__
        if self.__expect__(NUM):
            return Node(AST_NUM, value=self.__input__[self.__current_pos__ - 1].value)
        self.__reset_pos__(pos)

        if self.__expect__(FLOAT):
            return Node(AST_FLOAT, value=self.__input__[self.__current_pos__ - 1].value)
        self.__reset_pos__(pos)

        if self.__expect__(LPAREN) and (exp := self.expr()) and self.__expect__(RPAREN):
            return exp
        self.__reset_pos__(pos)

        return None


# Parser starten

if __name__ == '__main__':
    text = "(-23 + 16 )*- 4.23 ** -(2**2)"
    parser = Parser()
    lexer = Lexer()
    token_list = lexer.lex(text)
    is_correct = parser.parse(token_list)
    print(token_list)
    print(text)
    print(is_correct)
