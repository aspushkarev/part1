# Итератор, генерирующий целые числа, начиная с указанного
from itertools import count

num1 = int(input('Введите число 1: '))
num2 = int(input('Введите число 2: '))
for el in count(num1):
    if num2 < el:
        break
    print(el)
