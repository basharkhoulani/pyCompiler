# Tokentypes

TT_NUM = 'NUM'
TT_ADD = 'ADD'
TT_USUB = 'USUB'
TT_MULT = 'MULT'


class Token:
    def __init__(self, type, value=None):
        self.type = type
        self.value = value

    def __repr__(self):
        return f'Token({self.type},{self.value})'


if __name__ == '__main__':
    tok = Token(TT_ADD, 3)
    print(tok)