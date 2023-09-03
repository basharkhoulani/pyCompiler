x = input_int()
y = input_int()
if x > 0:
    if y > 0:
        if x >= 1:
            if y > 1:
                if x + y > 2:
                    print(42)
                else:
                    print(0)
            else:
                print(0)
        else:
            print(0)
    else:
        print(0)
else:
    print(0)
