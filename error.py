class LexerError(Exception):
    def __init__(self, found, expected, position):
        self.found = found
        self.expected = expected
        self.position = position

    def __str__(self):
        return f"LexerError: Expected {self.expected}, found {self.found} at position {self.position}"

    def __repr__(self):
        return str(self)


class ParserError(Exception):
    def __init__(self, found, expected, position, rule):
        self.found = found
        self.expected = expected
        self.position = position
        self.rule = rule

    def __str__(self):
        return f"ParserError: Expected {self.expected}, found {self.found} at position {self.position} in rule {self.rule}"

    def __repr__(self):
        return str(self)
