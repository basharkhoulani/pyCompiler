a = 0
b = 1
i = 0
n = input_int()
while i < n:
    a = b
    b = a + b
    i = i + 1
print(a)
