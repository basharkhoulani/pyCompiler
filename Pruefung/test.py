t1 = ((7,),42)
t2 = (t1,)

if t1 is t2[0]:
   print(1)
else:
   print(0)

# prints 1
   
print(1 if t1[0][0] < 3 else t2[0][1])

# prints 42

# x = input_int() + 3