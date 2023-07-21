nterms = input_int()
n1 = 0
n2 = 1
count = 0
while count < nterms:
    print(n1)
    nth = n1 + n2
    n1 = n2
    n2 = nth
    count = count + 1
