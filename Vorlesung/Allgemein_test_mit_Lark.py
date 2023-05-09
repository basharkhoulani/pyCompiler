from lark import Lark

grammar = '''

non_terminal_x :STRING_TERMINAL non_terminal_x STRING_TERMINAL
               |NUMBER_TERMINAL non_terminal_x NUMBER_TERMINAL
               |
STRING_TERMINAL : "a"
NUMBER_TERMINAL : /[1-9]+/

%import common.WS

%ignore WS

'''

parser = Lark(grammar, start='non_terminal_x')

parsetree = parser.parse("a 1 1 a")

print(parsetree.pretty())