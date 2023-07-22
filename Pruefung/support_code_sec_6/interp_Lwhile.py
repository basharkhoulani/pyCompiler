from ast import *
from interp_Lif import InterpLif
from utils import *

class InterpLwhile(InterpLif):

  def interp_stmt(self, s, env, cont):
    match s:
      case While(test, body, []):
        if self.interp_exp(test, env):
            self.interp_stmts(body + [s] + cont, env)
        else:
          return self.interp_stmts(cont, env)
      case _:
        return super().interp_stmt(s, env, cont)

if __name__ == '__main__':

  #import sys
  #sys.setrecursionlimit(10000)

  prog="""
x = 40
while x > 0:
    y = 2
    while y != 0:
        y = y - 1
    x = x - 1
print(x)
"""

  InterpLwhile().interp(parse(prog))
