from error import LexerError
from tokens import *
import re


class Lexer:
    pos: int
    input: str
    current_char: str

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
        pos = self.pos
        float_regex_str = r"((\d|[1-9]\d*)\.(0|\d*[1-9]))"
        matches = re.match(float_regex_str, self.input[self.pos:])
        if matches is None or matches.start(0) != 0:
            raise LexerError(self.input, self.current_char, "float", pos, self.pos)
        self.reset(self.pos + matches.end(0))
        if self.current_char == '0':
            raise LexerError(self.input, self.current_char, "no following zeros", pos, self.pos)
        return Token(FLOAT, matches.group(0), pos, self.pos)

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
        return Token(NUM, value, pos, self.pos)

    def lex(self, input_str: str) -> list[Token]:
        if len(input_str) == 0:
            return [Token(EOF)]

        self.pos = 0
        self.input = input_str
        self.current_char = self.input[self.pos]
        result = []

        while self.current_char is not None:
            match self.current_char:
                case '+':
                    result.append(Token(ADD, from_pos=self.pos, to_pos=self.pos))
                    self.move()
                case '*':
                    result.append(Token(MUL, from_pos=self.pos, to_pos=self.pos))
                    self.move()
                case '-':
                    result.append(Token(USUB, from_pos=self.pos, to_pos=self.pos))
                    self.move()
                case '(':
                    result.append(Token(LPAREN, from_pos=self.pos, to_pos=self.pos))
                    self.move()
                case ')':
                    result.append(Token(RPAREN, from_pos=self.pos, to_pos=self.pos))
                    self.move()
                case n if n.isdigit():
                    result.append(self.read_number())
                case n if n.isspace():
                    self.move()
                case _:
                    raise LexerError(self.input, self.current_char, "a valid token", self.pos, self.pos)

        result.append(Token(EOF, from_pos=self.pos, to_pos=self.pos))

        return result


if __name__ == '__main__':
    lexer = Lexer()
    print(lexer.lex("(-23 +16 )*- ; 4.23"))
