from tokens import *
import lexer


class Parser:
   def __init__(self, input: list[Token]) -> None:
      self.input = input
      self.__current_pos__ = 0
      self.__current_token__ = self.input[self.__current_pos__]

   # Hilfsfunktionen

   def __read_tok__(self):
      self.__current_pos__ += 1
      self.__current_token__ = self.input[self.__current_pos__]

   def __reset_pos__(self, pos: int):
      self.__current_pos__ = pos
      self.__current_token__ = self.input[self.__current_pos__]

   def __expect__(self, token_type: str) -> bool:
      if self.__current_token__.type == token_type:
         self.__read_tok__()
         return True
      else:
         return False

   # Grammatikregeln

   def expr(self):
      pos = self.__current_pos__
      if self.term() and self.__expect__(ADD) and self.expr():
         return True
      self.__reset_pos__(pos)

      if self.term():
         return True
      self.__reset_pos__(pos)

      return False

   def term(self):
      pos = self.__current_pos__
      if self.__expect__(USUB) and self.factor():
         return True
      self.__reset_pos__(pos)

      if self.factor():
         return True
      self.__reset_pos__(pos)

      return False

   def factor(self):
      pos = self.__current_pos__
      if self.__expect__(NUM):
         return True
      self.__reset_pos__(pos)

      return False

   # Parser starten

   def parse(self):
      if self.expr() and self.input[self.__current_pos__].type == EOF:
         return True
      else:
         return False


if __name__ == '__main__':
   token_list = lexer.Lexer('3+-3').lex()
   print(token_list)
   print(Parser(token_list).parse())
