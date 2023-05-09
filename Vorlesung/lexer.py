from tokens import *

token_list = []


class Lexer:
    def __init__(self, input: str):
        self.input: str = input
        self.pos: int = 0
        self.current_symbol = self.input[self.pos]

    def __move__(self):
        if self.pos < len(self.input) - 1:
            self.pos += 1
            self.current_symbol = self.input[self.pos]
        else:
            self.current_symbol = None

    ### Tokenfunktionen
    def num(self):
        num_value = ''
        while self.current_symbol != None and self.current_symbol.isdigit():
            num_value += self.current_symbol
            self.move()
        return Token(TT_NUM, num_value)

    def lex(self):
        # token_list = []

        while self.current_symbol != None:
            match self.current_symbol:
                case '+':
                    token_list.append(Token(TT_ADD))
                case '-':
                    token_list.append(Token(TT_USUB))
                case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9':
                    token_list.append(self.num())

    def __repr__(self):
        return token_list


print(Lexer('-23+26+8'))