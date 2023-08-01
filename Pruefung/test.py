t0 = (1,)
x = len(t0) == 0
t = (1 if x else 2, (3, 4))

print(1 if t[0] == 2 else 0)
print(1 if t[1][0] == 3 else 0)
print(1 if t[1][1] == 4 else 0)