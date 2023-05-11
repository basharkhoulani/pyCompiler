from lark import Lark, Transformer, v_args


def test_grammar(file: str) -> None:
    with open(file, 'r') as grammar_file:
        grammar = grammar_file.read()

    #########
    # Parse #
    #########

    parser = Lark(grammar, start='exp')  # ,ambiguity = 'explicit')

    parsetree = parser.parse('1+-2+-3')

    print(parsetree.pretty())

    print(CalcInterpreterPretty().transform(parsetree))


###################
# TreeTransformer #
###################

# klassische Verwendung
class CalcInterpreter(Transformer):
    @staticmethod
    def num(tree):
        return int(tree[0].value)

    @staticmethod
    def add(tree):
        return tree[0] + tree[1]


# Verwendung mit Decorator, der die Kinder eines Teilbaums als *args in die
# Transformer-Methoden aufnimmt
@v_args(inline=True)
class CalcInterpreterPretty(Transformer):
    @staticmethod
    def num(num):
        return int(num.value)

    @staticmethod
    def usub(child):
        return -child

    @staticmethod
    def add(left, right):
        return left + right


if __name__ == '__main__':
    test_grammar('calc.lark')