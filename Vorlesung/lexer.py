from tokens import *


class Lexer:
    def __init__(self, input):
        self.pos = 0
        self.text = input
        self.current_sym = self.text[self.pos]

    ####################################
    ### Automaton Control
    ####################################

    def move(self):
        '''Moves the head one position, if possible.'''

        if self.pos + 1 < len(self.text):
            self.pos += 1
            self.current_sym = self.text[self.pos]
        else:
            self.current_sym = None

    ####################################
    ### Token implementation
    ####################################

    def num(self):
        '''Matches (maxmatch) and returns NUM-tokens.'''
        value = ''
        while self.current_sym is not None and self.current_sym.isdigit():
            value += self.current_sym
            self.move()

        return Token(TT_NUM, value)

    ####################################
    ### main
    ####################################

    def lex(self):
        '''Scans the input symbolwise and returns a list of matched tokens.'''
        token_list = []

        while self.current_sym is not None:

            match self.current_sym:
                case '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9':
                    token_list.append(self.num())
                case '+':
                    token_list.append(Token(TT_ADD))
                    self.move()
                case '-':
                    token_list.append(Token(TT_USUB))
                    self.move()
                case _:
                    raise SyntaxError('Unexpected Token!')

        token_list.append(Token(TT_EOF))

        return token_list


if __name__ == '__main__':
    print(Lexer('02+33').lex())

