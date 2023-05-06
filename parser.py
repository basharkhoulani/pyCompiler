from error import ParserError
from tokens import *
from asts import *
from lexer import *
from typing import Optional


class Parser:
    __input__: list[Token]
    __current_pos__: int
    __current_token__: Token
    __furthest_pos__: int
    __furthest_token__: Token
    __furthest_rule__: str
    __furthest_expected__: str

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

    def __failed__(self, expected: str, rule: str) -> None:
        if self.__current_pos__ > self.__furthest_pos__:
            self.__furthest_pos__ = self.__current_pos__
            self.__furthest_token__ = self.__current_token__
            self.__furthest_rule__ = rule
            self.__furthest_expected__ = expected

    def parse(self, tokens: list[Token]) -> Optional[Ast]:
        self.__input__ = tokens
        self.__current_pos__ = 0
        self.__current_token__ = self.__input__[self.__current_pos__]
        self.__furthest_pos__ = 0
        self.__furthest_token__ = self.__input__[self.__furthest_pos__]
        self.__furthest_rule__ = ""
        self.__furthest_expected__ = ""

        if (exp := self.expr()) and self.__input__[self.__current_pos__].type == EOF:
            return Ast(exp)
        elif exp and self.__input__[self.__current_pos__].type != EOF:
            raise ParserError(self.__current_token__, "EOF", self.__current_pos__, "parse")
        else:
            raise ParserError(self.__furthest_token__, self.__furthest_rule__, self.__furthest_pos__, self.__furthest_rule__)


# Grammatikregeln

    def expr(self) -> Optional[Node]:
        return self.pow()

    def pow(self) -> Optional[Node]:
        pos = self.__current_pos__

        if (lhs := self.mul()) and (b1 := self.__expect__(MUL)) and (b2 := self.__expect__(MUL)) and (rhs := self.expr()):
            return Node(AST_POW, children=[lhs, rhs])
        else:
            self.__failed__("expr", "pow")
        self.__reset_pos__(pos)

        if mul := self.mul():
            return mul
        else:
            self.__failed__("mul", "pow")
        self.__reset_pos__(pos)

        return None

    def mul(self) -> Optional[Node]:
        pos = self.__current_pos__

        if (lhs := self.add()) and self.__expect__(MUL) and (rhs := self.expr()):
            return Node(AST_MUL, children=[lhs, rhs])
        else:
            self.__failed__("expr", "mul")
        self.__reset_pos__(pos)

        if add := self.add():
            return add
        else:
            self.__failed__("add", "mul")
        self.__reset_pos__(pos)

        return None

    def add(self) -> Optional[Node]:
        pos = self.__current_pos__
        if (lhs := self.term()) and self.__expect__(ADD) and (rhs := self.expr()):
            return Node(AST_ADD, children=[lhs, rhs])
        else:
            self.__failed__("expr", "add")
        self.__reset_pos__(pos)

        if term := self.term():
            return term
        else:
            self.__failed__("term", "add")
        self.__reset_pos__(pos)

        return None

    def term(self) -> Optional[Node]:
        pos = self.__current_pos__
        if self.__expect__(USUB) and (rhs := self.factor()):
            return Node(AST_USUB, children=[rhs])
        else:
            self.__failed__("factor", "term")
        self.__reset_pos__(pos)

        if factor := self.factor():
            return factor
        else:
            self.__failed__("factor", "term")
        self.__reset_pos__(pos)

        return None

    def factor(self) -> Optional[Node]:
        pos = self.__current_pos__
        if self.__expect__(NUM):
            return Node(AST_NUM, value=self.__input__[self.__current_pos__ - 1].value)
        else:
            self.__failed__("number", "factor")
        self.__reset_pos__(pos)

        if self.__expect__(FLOAT):
            return Node(AST_FLOAT, value=self.__input__[self.__current_pos__ - 1].value)
        else:
            self.__failed__("float", "factor")
        self.__reset_pos__(pos)

        if self.__expect__(LPAREN) and (exp := self.expr()) and self.__expect__(RPAREN):
            return exp
        else:
            self.__failed__("expr", "factor")
        self.__reset_pos__(pos)

        return None


# Parser starten

if __name__ == '__main__':
    text = "(1 ++ 2 )"
    parser = Parser()
    lexer = Lexer()
    token_list = lexer.lex(text)
    ast = parser.parse(token_list)
    print(token_list)
    print(text)
    print(ast)
    print("evaluates to: ", ast.eval())
