NUM = 'NUM'
FLOAT = 'FLOAT'
ADD = 'ADD'
MUL = 'MULT'
EXP = 'EXP'
USUB = 'USUB'
LPAREN = 'LPAR'
RPAREN = 'RPAR'
EOF = 'EOF'


class Token:
    def __init__(self, type, value=None):
        self.type = type
        self.value = value

    def __repr__(self):
        if self.value is not None:
            return f'Token({self.type},{self.value})'
        else:
            return f'Token({self.type})'
