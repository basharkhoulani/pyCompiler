import math

from lark import Lark, Transformer, v_args


def run_calculator() -> None:
    with open('calc.lark', 'r') as grammar_file:
        grammar = grammar_file.read()
    parser = Lark(grammar, start='exp', ambiguity='explicit')
    interpreter = CalcInterpreterPretty()

    print("Commands:",
          "'exit' -> exit",
          "'tr <expr>' -> print parse tree + run expr",
          "'<expr>' -> run expr", sep="\n\t")

    while True:
        input_str = input(">> ")
        if input_str == "exit":
            break
        print_tree = input_str.startswith("tr ")
        input_str = input_str[3:] if print_tree else input_str
        try:
            tree = parser.parse(input_str)
            if print_tree:
                print(tree.pretty())
            result = interpreter.transform(tree)
            print("=", result)
        except Exception as e:
            print(e)


@v_args(inline=True)
class CalcInterpreterPretty(Transformer):
    @staticmethod
    def number(num):
        return float(num.value)

    @staticmethod
    def usub(child):
        return -child

    @staticmethod
    def add(left, right):
        return left + right

    @staticmethod
    def sub(left, right):
        return left - right

    @staticmethod
    def mul(left, right):
        return left * right

    @staticmethod
    def div(left, right):
        return left / right

    @staticmethod
    def pow(left, right):
        return left ** right

    @staticmethod
    def exp(child):
        return child

    @staticmethod
    def func(*args):
        name = args[0]
        params = args[1:]
        match name:
            case "sin":
                return math.sin(*params)
            case "cos":
                return math.cos(*params)
            case "tan":
                return math.tan(*params)
            case "sqrt":
                return math.sqrt(*params)
            case "log":
                return math.log(*params)
            case _:
                raise Exception(f"Unknown function '{name}'")


if __name__ == '__main__':
    run_calculator()
