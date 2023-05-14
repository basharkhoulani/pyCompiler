from lark import Lark, Transformer, v_args

with open('calc.lark', 'r') as grammar_file:
    grammar = grammar_file.read()

#########################
### Parse
#########################

parser = Lark(grammar, start='exp', ambiguity='explicit')

parsetree = parser.parse('2**2**2')

print(parsetree.pretty())


##########################
### TreeTransformer
##########################

# Verwendung mit Decorator, der die Kinder eines Teilbaums als *args in die
# Transformer-Methoden aufnimmt
@v_args(inline=True)
class CalcInterpreterPretty(Transformer):
    def number(self, num):
        return int(num.value)

    def usub(self, child):
        return -child

    def add(self, left, right):
        return left + right

    def mult(self, left, right):
        return left * right

    def pow(self, left, right):
        return left ** right

    def div(self, left, right):
        return left / right

    def sub(self, left, right):
        return left - right
    def exp(self,child):
        return child

print(CalcInterpreterPretty().transform(parsetree))
