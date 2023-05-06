class LexerError(Exception):
    def __init__(self, input, found, expected, from_pos, to_pos):
        self.input = input
        self.found = found
        self.expected = expected
        self.from_pos = from_pos
        self.to_pos = to_pos

    def __str__(self):
        msg = "\n" + self.input + "\n"
        msg += "-" * self.from_pos + "^" * (self.to_pos - self.from_pos + 1) + "\n"
        msg += f"LexerError: Expected {self.expected} but found {self.found}"
        return msg

    def __repr__(self):
        return str(self)


class ParserError(Exception):
    def __init__(self, input, found, expected, from_pos, to_pos, rule):
        self.input = input
        self.found = found
        self.expected = expected
        self.from_pos = from_pos
        self.to_pos = to_pos
        self.rule = rule

    def __str__(self):
        msg = "\n" + self.input + "\n"
        msg += "-" * self.from_pos + "^" * (self.to_pos - self.from_pos + 1) + "\n"
        msg += f"ParserError: Expected {self.expected} but found {self.found} in rule {self.rule}"
        return msg

    def __repr__(self):
        return str(self)
