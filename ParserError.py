
class ParserError(Exception):
    def __init__(self, found, position, lastRule):
        self.found = found
        self.position = position
        self.lastRule = lastRule

    def __str__(self):
        return f"ParserError: found {self.found} at position {self.position}, last Rule used {self.lastRule}"
