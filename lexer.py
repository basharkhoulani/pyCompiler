from error import LexerError
from tokens import *
import re


class Lexer:
    def __init__(self, input: str):
        self.input = input
        self.pos = 0
        self.current_char = self.input[self.pos]

    def move(self):
        self.pos += 1
        if self.pos >= len(self.input):
            self.current_char = None
        else:
            self.current_char = self.input[self.pos]

    def add_and_move(self, char):
        self.move()
        return char

    def reset(self, pos):
        self.pos = pos
        if self.pos >= len(self.input):
            self.current_char = None
        else:
            self.current_char = self.input[self.pos]

    def peek(self):
        peek_pos = self.pos + 1
        if peek_pos >= len(self.input):
            return None
        else:
            return self.input[peek_pos]

    def read_float(self):
        float_regex_str = r"((\d|[1-9]\d*)\.(0|\d*[1-9]))"
        matches = re.match(float_regex_str, self.input[self.pos:])
        if matches is None or matches.start(0) != 0:
            raise LexerError(self.current_char, "float", self.pos)
        self.reset(self.pos + matches.end(0))
        if self.current_char == '0':
           raise LexerError(self.current_char, "no leading zeros", self.pos)
        return Token(TT_FLOAT, matches.group(0))

    def read_number(self):
        value = ''
        pos = self.pos
        while self.current_char is not None and self.current_char.isdigit():
           value += self.current_char
           self.move()
        # if encountered a dot, read float instead
        if self.current_char == '.':
           self.reset(pos)
           return self.read_float()
        return Token(TT_NUM,value)

    def lex(self):
        result = []

        while self.current_char is not None:
            match self.current_char:
                case '+':
                    result.append(Token(TT_ADD))
                    self.move()
                case '*':
                    result.append(Token(TT_MUL))
                    self.move()
                case '-':
                    result.append(Token(TT_USUB))
                    self.move()
                case '(':
                    result.append(Token(TT_LPAREN))
                    self.move()
                case ')':
                    result.append(Token(TT_RPAREN))
                    self.move()
                case n if n.isdigit():
                    result.append(self.read_number())
                case n if n.isspace():
                    self.move()
                case _:
                    raise LexerError(self.current_char, "a valid token", self.pos)
        return result


if __name__ == '__main__':
    lexer = Lexer("(-23 +16 )*- 04.23")
    print(lexer.lex())
    