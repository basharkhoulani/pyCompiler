import re


# Beispiel

def match_aaba(input: str):
    if re.fullmatch(r"a[ab]*a", input) is not None:
        return True
    else:
        return False


# Aufgabe 1a

def match_identifier(input: str):
    return re.fullmatch(r"[a-zA-Z]\w*", input) is not None


# Aufgabe 1b

def match_float_literal(input: str):
    return re.fullmatch(r"((\d|[1-9]\d*)\.(0|\d*[1-9]))", input) is not None


# Aufgabe 1c

def match_comment(input: str):
    return re.fullmatch(r"/\*([^*]|\*[^/])*\*/", input) is not None


# Test

if __name__ == "__main__":
    # Match aaba
    print("---------- Match aaba ----------")
    print(str(match_aaba("aa")) + " (should be True)")
    print(str(match_aaba("aaba")) + " (should be True)")
    print(str(match_aaba("aaaa")) + " (should be True)")
    print(str(match_aaba("baaa")) + " (should be False)")
    print("--------------------")
    # Match identifier
    print("---------- Match identifier ----------")
    print(str(match_identifier("123NotAnIdentifier")) + " (should be False)")
    print(str(match_identifier("_NotAnIdentifier")) + " (should be False)")
    print(str(match_identifier("this_is_snake_case")) + " (should be True)")
    print(str(match_identifier("ThisIsPascalCase")) + " (should be True)")
    print(str(match_identifier("thisIsCamelCase")) + " (should be True)")
    print(str(match_identifier("testus")) + " (should be True)")
    print(str(match_identifier("testus123")) + " (should be True)")
    print("--------------------")
    # Match float literal
    print("---------- Match float literal ----------")
    print(str(match_float_literal("0.0")) + " (should be True)")
    print(str(match_float_literal("123.01")) + " (should be True)")
    print(str(match_float_literal("123005.0")) + " (should be True)")
    print(str(match_float_literal("00.0")) + " (should be False)")
    print(str(match_float_literal("001.000")) + " (should be False)")
    print(str(match_float_literal("1234.00")) + " (should be False)")
    print(str(match_float_literal("1234.")) + " (should be False)")
    print(str(match_float_literal(".0")) + " (should be False)")
    print(str(match_float_literal(".000")) + " (should be False)")
    print(str(match_float_literal("0.")) + " (should be False)")
    print(str(match_float_literal("0.000")) + " (should be False)")
    print("--------------------")
    # Match comment
    print("---------- Match comment ----------")
    print(str(match_comment("/* This is a\r\n\t comment */")) + " (should be True)")
    print(str(match_comment("// This is not a comment")) + " (should be False)")
    print(str(match_comment("/ This is not a comment")) + " (should be False)")
    print(str(match_comment("This is also not a comment")) + " (should be False)")
    print(str(match_comment("/* This is not a comment")) + " (should be False)")
    print(str(match_comment("/* This is not a comment */ */")) + " (should be False)")
    print(str(match_comment("/* This is a comment /* */")) + " (should be True)")
    print(str(match_comment("/* This is not a comment */ */")) + " (should be False)")
    print(str(match_comment("/* This is not a comment /* /* */ */")) + " (should be False)")
    print(str(match_comment("/* This is not a comment /* /* /* */ */ */ */")) + " (should be False)")
    print(str(match_comment("/*** This is not a comment /***/**")) + " (should be False)")
    print(str(match_comment("/*** This is not a comment /***/")) + " (should be True)")
    print(str(match_comment("/* /* /*Hallo*/")) + " (should be True)")
    print("--------------------")
