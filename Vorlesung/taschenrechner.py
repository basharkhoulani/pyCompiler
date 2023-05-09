from lark import Lark

calc_grammar = '''

exp : NUMBER -> num
    |"-" exp -> usub
    |exp "+" exp -> add
    |"("exp")"
    
DIGIT: /[1-9]/
NUMBER: DIGIT+
'''

parser = Lark(calc_grammar, start='exp', ambiguity='explicit')

parsetree = parser.parse('3+-4+5')

print(parsetree.pretty())
