from git.error import LexerError
from tokens import *


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

    def peek(self):
        peek_pos = self.pos + 1
        if peek_pos >= len(self.input):
            return None
        else:
            return self.input[peek_pos]

    def read_number(self):
        num_text = ""
        if self.current_char == '0':
            num_text += self.add_and_move(self.current_char)
            if self.current_char == '.':
                num_text += self.add_and_move(self.current_char)
                return self.read_float(num_text)
            elif self.current_char.isdigit():
                raise LexerError("Leading zero", self.pos)
            else:
                return Token(TT_NUM, num_text)
        while self.current_char is not None and (self.current_char.isdigit() or self.current_char == '.'):
            if self.current_char == '.':
                num_text += self.add_and_move(self.current_char)
                return self.read_float(num_text)
            num_text += self.add_and_move(self.current_char)
        return Token(TT_NUM, num_text)

    def read_float(self, num_text):
        trailing_zero = False
        while self.current_char is not None and self.current_char.isdigit():
            if self.current_char == '0' and trailing_zero:
                raise LexerError("Trailing zero", self.pos)
            elif self.current_char != '0':
                trailing_zero = False
            elif self.current_char == '0':
                trailing_zero = True
                if self.peek() is None:
                    raise LexerError("Trailing zero", self.pos)
            elif self.current_char == '.':
                raise LexerError("Multiple decimal points", self.pos)
            num_text += self.add_and_move(self.current_char)
        return Token(TT_FLOAT, num_text)

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
                    raise LexerError("Unknown character", self.pos)
        return result


if __name__ == '__main__':
    lexer = Lexer("(-23 +16 )*- 4.23")
    print(lexer.lex())
    pass
