"""
Write a function that takes a string and calculates the number of letters and digits within it. Return the result in a dictionary.

Examples:
    count_all("Hello World") ➞ { "LETTERS":  10, "DIGITS": 0 }

    count_all("H3ll0 Wor1d") ➞ { "LETTERS":  7, "DIGITS": 3 }

    count_all("149990") ➞ { "LETTERS": 0, "DIGITS": 6 }

Notes:
    - Tests contain only alphanumeric characters.
    - Spaces are not letters.
    - All tests contain valid strings.
    - The function should return dictionary

"""

def count_all(string):        
    
    letter_count = 0
    digit_count = 0
    
    for character in string:
        
        if character == " ":
            continue
        
        try:
            int(character)
            digit_count += 1
            continue
        
        except:
            pass
        
        if type(character) == str:
            letter_count += 1
            continue                
    
    answer_dict = {"LETTERS":letter_count, "DIGITS":digit_count}
    
    return answer_dict                                  