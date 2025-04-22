def longest_str(string):
    string_ = ""
    for char in string:
        if char in string_:
            break
        string_ += char
    return string_