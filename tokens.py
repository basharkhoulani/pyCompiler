TT_NUM = 'NUM'
TT_FLOAT = 'FLOAT'
TT_ADD = 'ADD'
TT_MUL = 'MULT'
TT_USUB = 'USUB'
TT_LPAREN = 'LPAR'
TT_RPAREN = 'RPAR'


class Token:
    def __init__(self, type, value=None):
        self.type = type
        self.value = value

    def __repr__(self):
        if self.value:
            return f"({self.type}, {self.value})"
        else:
            return f"{self.type}"


if __name__ == "__main__":
    pass
