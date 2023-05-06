class LexerError(Exception):
    def __init__(self, found, expected, position):
        self.found = found
        self.expected = expected
        self.position = position

    def __str__(self):
        return f"LexerError: Expected {self.expected}, found {self.found} at position {self.position}"


class ParserError(Exception):
    def __init__(self, failed_token, position, rule):
        self.failed_token = failed_token
        self.position = position
        self.rule = rule

    def __str__(self):
        return f"ParserError: Found {self.failed_token} at position {self.position} in rule {self.rule}"
