a = input_int()
b = input_int()
while b != 0:
    if a > b:
        a = a - b
    else:
        b = b - a
print(a)
