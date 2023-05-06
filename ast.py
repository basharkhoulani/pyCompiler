from tokens import Token


class Node:
    token: Token
    children: list['Node']

    def __init__(self, token: Token, children: list['Node'] = None):
        self.token = token
        self.children = children if children is not None else []

    def __str__(self):
        return f'Node ({self.token})\n' + '\n'.join(['\t' + str(child) for child in self.children])
