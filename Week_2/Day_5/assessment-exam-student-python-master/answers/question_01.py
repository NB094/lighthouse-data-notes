"""
Create a function that returns the mean of all digits.

Example:
    mean(42) ➞ 3.0

    mean(12345) ➞ 3.0

    mean(666) ➞ 6.0

Notes:
    - Function should always return float
"""


def mean(digits):
    
    numerator = 0
    denominator = 0
    
    for digit in map(int, str(digits)):
        numerator += digit
        denominator += 1
    
    return numerator/denominator