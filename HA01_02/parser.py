from error import ParserError
from tokens import *
from asts import *
from lexer import *
from typing import Optional
from inspect import stack


class Parser:
    __input__: list[Token]
    __current_pos__: int
    __current_token__: Token
    __furthest_pos_begin__: int
    __furthest_pos_end__: int
    __furthest_token__: Token
    __furthest_rule__: str
    __furthest_expected__: str
    __memo__: dict[tuple[int, str], tuple[Optional[Node], int]] = {}
    saved_entries: int = 0
    accessed_entries: int = 0

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

    def __memo_it__(self, pos: int, val: Optional[Node]) -> any:
        self.saved_entries += 1
        self.__memo__[(pos, stack()[1][3])] = (val, self.__current_pos__)
        return val

    def __memo_contains__(self) -> bool:
        return (self.__current_pos__, stack()[1][3]) in self.__memo__

    def __memo_get__(self) -> Optional[Node]:
        self.accessed_entries += 1
        tp = self.__memo__[(self.__current_pos__, stack()[1][3])]
        self.__reset_pos__(tp[1])
        return tp[0]

    def __failed__(self, expected: str) -> None:
        if self.__current_token__.to_pos >= self.__furthest_pos_end__:
            self.__furthest_pos_begin__ = self.__current_token__.from_pos
            self.__furthest_pos_end__ = self.__current_token__.to_pos
            self.__furthest_token__ = self.__current_token__
            self.__furthest_rule__ = stack()[1][3]
            self.__furthest_expected__ = expected

    def parse(self, input: str, tokens: list[Token]) -> Optional[Ast]:
        if len(tokens) == 1 and tokens[0].type == EOF:
            raise ParserError(input, Token(EOF), "expr", 0, 0, "parse")

        self.__input__ = tokens
        self.__current_pos__ = 0
        self.__current_token__ = self.__input__[self.__current_pos__]
        self.__furthest_pos_begin__ = 0
        self.__furthest_pos_end__ = 0
        self.__furthest_token__ = self.__input__[self.__current_pos__]
        self.__furthest_rule__ = ""
        self.__furthest_expected__ = ""
        self.__memo__ = {}

        if (exp := self.expr()) and self.__input__[self.__current_pos__].type == EOF:
            return Ast(exp)
        else:
            raise ParserError(input, self.__furthest_token__, self.__furthest_expected__, self.__furthest_pos_begin__,
                              self.__furthest_pos_end__, self.__furthest_rule__)

    # Grammatikregeln

    # E -> A
    # A -> M + A | M
    # M -> P * M | P
    # P -> T ** P | T
    # T -> -F | F
    # F -> (E) | NUM | FLOAT

    # E -> A
    def expr(self) -> Optional[Node]:
        if self.__memo_contains__():
            return self.__memo_get__()
        return self.__memo_it__(self.__current_pos__, self.add())

    # A -> M + A | M
    def add(self) -> Optional[Node]:
        if self.__memo_contains__():
            return self.__memo_get__()

        pos = self.__current_pos__
        if (lhs := self.mul()) and self.__expect__(ADD) and (rhs := self.add()):
            return self.__memo_it__(pos, Node(AST_ADD, children=[lhs, rhs]))
        else:
            self.__failed__("expr")
        self.__reset_pos__(pos)

        if term := self.mul():
            return self.__memo_it__(pos, term)
        else:
            self.__failed__("term")
        self.__reset_pos__(pos)

        return self.__memo_it__(pos, None)

    # M -> P * M | P
    def mul(self) -> Optional[Node]:
        if self.__memo_contains__():
            return self.__memo_get__()

        pos = self.__current_pos__

        if (lhs := self.pow()) and self.__expect__(MUL) and (rhs := self.mul()):
            return self.__memo_it__(pos, Node(AST_MUL, children=[lhs, rhs]))
        else:
            self.__failed__("expr")
        self.__reset_pos__(pos)

        if add := self.pow():
            return self.__memo_it__(pos, add)
        else:
            self.__failed__("add")
        self.__reset_pos__(pos)

        return self.__memo_it__(pos, None)

    # P -> T ** P | T
    def pow(self) -> Optional[Node]:
        if self.__memo_contains__():
            return self.__memo_get__()

        pos = self.__current_pos__

        if (lhs := self.term()) and (b1 := self.__expect__(MUL)) \
                and (b2 := self.__expect__(MUL)) and (rhs := self.pow()):
            return self.__memo_it__(pos, Node(AST_POW, children=[lhs, rhs]))
        else:
            self.__failed__("pow")

        self.__reset_pos__(pos)

        if mul := self.term():
            return self.__memo_it__(pos, mul)
        else:
            self.__failed__("mul")
        self.__reset_pos__(pos)

        return self.__memo_it__(pos, None)

    # T -> -F | F
    def term(self) -> Optional[Node]:
        if self.__memo_contains__():
            return self.__memo_get__()

        pos = self.__current_pos__
        if self.__expect__(USUB) and (rhs := self.term()):
            return self.__memo_it__(pos, Node(AST_USUB, children=[rhs]))
        else:
            self.__failed__("factor")
        self.__reset_pos__(pos)

        if factor := self.factor():
            return self.__memo_it__(pos, factor)
        else:
            self.__failed__("factor")
        self.__reset_pos__(pos)

        return self.__memo_it__(pos, None)

    # F -> (E) | NUM | FLOAT
    def factor(self) -> Optional[Node]:
        if self.__memo_contains__():
            return self.__memo_get__()

        pos = self.__current_pos__
        if self.__expect__(NUM):
            return self.__memo_it__(pos, Node(AST_NUM, value=self.__input__[self.__current_pos__ - 1].value))
        else:
            self.__failed__("number")
        self.__reset_pos__(pos)

        if self.__expect__(FLOAT):
            return self.__memo_it__(pos, Node(AST_FLOAT, value=self.__input__[self.__current_pos__ - 1].value))
        else:
            self.__failed__("float")
        self.__reset_pos__(pos)

        if (lp := self.__expect__(LPAREN)) and (exp := self.expr()) and (rp := self.__expect__(RPAREN)):
            return self.__memo_it__(pos, exp)
        elif lp and exp and not rp:
            self.__failed__(")")
        else:
            self.__failed__("expr")
        self.__reset_pos__(pos)

        return self.__memo_it__(pos, None)


# Parser starten

if __name__ == '__main__':
    text = "(2 + 3 ) * 4"
    parser = Parser()
    lexer = Lexer()
    token_list = lexer.lex(text)
    ast = parser.parse(text, token_list)

    print(f"{text=}")
    print(f"{token_list=}")
    print(f"{ast=}")
    print(f"{ast.eval()=}")
    print(f"{parser.saved_entries=}")
    print(f"{parser.accessed_entries=}")
