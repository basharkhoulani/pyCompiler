class LexerError(Exception):
    def __init__(self, found, expected, position):
         self.found = found
         self.expected = expected
         self.position = position

    def __str__(self):
         return f"LexerError: Expected {self.expected}, found {self.found} at position {self.position}"