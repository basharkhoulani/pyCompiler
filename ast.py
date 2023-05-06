from typing import Optional

from tokens import Token

AST_POW = 'AST_POW'
AST_MUL = 'AST_MUL'
AST_ADD = 'AST_ADD'
AST_USUB = 'AST_USUB'
AST_NUM = 'AST_NUM'
AST_FLOAT = 'AST_FLOAT'


def __indent__(txt: str) -> str:
    return '\n'.join(['\t' + line for line in txt.split('\n')])


class Node:
    type: str
    value: Optional[str]
    children: list['Node']

    def __init__(self, type_: str, value: str = None, children: list['Node'] = None):
        self.type = type_
        self.value = value
        self.children = children if children is not None else []

    def __str__(self):
        return f'Node ({self.type}{":" + self.value if self.value is not None else ""})' + \
            ("\n" if len(self.children) > 0 else "") + \
            '\n'.join([__indent__(str(child)) for child in self.children])

    def __repr__(self):
        return str(self)


class Ast:
    root: Node

    def __init__(self, root: Node):
        self.root = root

    def __str__(self):
        return str(self.root)

    def __repr__(self):
        return str(self.root)
