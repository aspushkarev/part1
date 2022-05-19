class ComplexNumber:
    def __init__(self, num1, num2):
        self.num1 = num1
        self.num2 = num2
        print(f'{self.num1} + {self.num2}j')

    def __mul__(self, other):
        a1 = self.num1 * other.num1
        a2 = self.num1 * other.num2
        b1 = self.num2 * other.num1
        b2 = self.num2 * other.num2
        a = a1 - b2
        b = a2 + b1
        print(f'Умножение двух комплексных чисел равно:')
        return f'{a} + {b}j'

    def __add__(self, other):
        a = self.num1 + other.num1
        b = self.num2 + other.num2
        print(f'Сумма двух комплексных чисел равна:')
        return f'{a} + {b}j'


cn1 = ComplexNumber(3, 2)
cn2 = ComplexNumber(2, 4)
# cn3 = ComplexNumber(2, 5)
print(cn1 + cn2)
print(cn1 * cn2)
