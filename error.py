class LexerError(Exception):
    def __init__(self, found, expected, position):
        self.found = found
        self.expected = expected
        self.position = position

    def __str__(self):
        return f"LexerError: Expected {self.expected}, found {self.found} at position {self.position}"


class ParserError(Exception):
    def __init__(self, found: str, pos: int, rule: str):
        self.found = found
        self.pos = pos
        self.rule = rule

    def __str__(self):
        return f"ParserError: Expected {self.rule}, found {self.found} at position {self.pos}"
