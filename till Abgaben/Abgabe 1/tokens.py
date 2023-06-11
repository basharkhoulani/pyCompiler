# definiere Tokentypen
NUM = 'NUM'
ADD = 'ADD'
USUB = 'USUB'
EOF = 'EOF'
MULT = 'MULT'
RPAR = 'RPAR'
LPAR = 'LPAR'




class Token:
    def __init__(self, type, val = None):
        self.type = type
        self.value = val

    def __repr__(self):
        if self.value != None:
            return f'Token({self.type},{self.value})'
        else:
            return f'Token({self.type})'


if __name__== '__main__':
    t1 = Token(NUM,1234)
    print(t1)