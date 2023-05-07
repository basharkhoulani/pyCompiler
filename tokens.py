NUM = 'NUM'
FLOAT = 'FLOAT'
ADD = 'ADD'
MUL = 'MULT'
USUB = 'USUB'
LPAREN = 'LPAR'
RPAREN = 'RPAR'
EOF = 'EOF'


class Token:
    def __init__(self, type, value=None, from_pos=None, to_pos=None):
        self.type = type
        self.value = value
        self.from_pos = from_pos
        self.to_pos = to_pos

    def __repr__(self):
        if self.value is not None:
            return f'Token({self.type},{self.value})'
        else:
            return f'Token({self.type})'
