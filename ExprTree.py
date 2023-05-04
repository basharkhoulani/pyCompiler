
class Expr:
    pass
    
class Add(Expr):
    def __init__(self,expr1,expr2):
        self.expr1 = expr1
        self.expr2 = expr2

    def __repr__(self):
            return f'Add({self.expr1},{self.expr2})'

        
class Mult(Expr):
    def __init__(self,expr1,expr2):
        self.expr1 = expr1
        self.expr2 = expr2

    def __repr__(self):
            return f'Mult({self.expr1},{self.expr2})'

class Potenz(Expr):
    def __init__(self,expr1,expr2):
        self.expr1 = expr1
        self.expr2 = expr2

    def __repr__(self):
            return f'Potenz({self.expr1},{self.expr2})'

class Usub(Expr):
    def __init__(self,expr):
        self.expr = expr
        
    def __repr__(self):
            return f'Usub({self.expr})'
    
class Num(Expr):
    def __init__(self,value):
        self.value = value

    def __repr__(self):
            return f'Num({self.value})'

class Float(Expr):
    def __init__(self,value):
        self.value = value

    def __repr__(self):
            return f'Float({self.value})'
