from error import LexerError
from tokens import *
import re


class Lexer:
    def __init__(self, input: str):
        self.pos = 0
        self.input = input
        if len(input) > 0:
            self.current_char = input[self.pos]
        else:
            self.current_char = None

    def move(self):
        if self.pos + 1 < len(self.input):
            self.pos += 1
            self.current_char = self.input[self.pos]
        else:
            self.current_char = None

    def reset(self, pos):
        self.pos = pos
        if self.pos >= len(self.input):
            self.current_char = None
        else:
            self.current_char = self.input[self.pos]

    def read_float(self):
        float_regex_str = r"((\d|[1-9]\d*)\.(0|\d*[1-9]))"
        matches = re.match(float_regex_str, self.input[self.pos:])
        if matches is None or matches.start(0) != 0:
            raise LexerError(self.current_char, "float", self.pos)
        self.reset(self.pos + matches.end(0))
        if self.current_char == '0':
            raise LexerError(self.current_char, "no leading zeros", self.pos)
        return Token(FLOAT, matches.group(0))

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
        return Token(NUM, value)

    def read_mult_or_exp(self):
        self.move()
        if self.current_char == '*':
            self.move()
            return Token(EXP)
        else:
            return Token(MUL)

    def lex(self):
        result = []

        if self.current_char is None:
            result.append(Token(EOF))
            return result

        while self.current_char is not None:
            match self.current_char:
                case '+':
                    result.append(Token(ADD))
                    self.move()
                case '*':
                    result.append(self.read_mult_or_exp())
                case '-':
                    result.append(Token(USUB))
                    self.move()
                case '(':
                    result.append(Token(LPAREN))
                    self.move()
                case ')':
                    result.append(Token(RPAREN))
                    self.move()
                case n if n.isdigit():
                    result.append(self.read_number())
                case n if n.isspace():
                    self.move()
                case _:
                    raise LexerError(self.current_char, "a valid token", self.pos)

        result.append(Token(EOF))

        return result


if __name__ == '__main__':
    lexer = Lexer("")
    print(lexer.lex())
