# Функция отвечает за получение факториала числа

def fact(n):
    result = 1
    if n == 0:
        yield 1
    for i in range(1, n + 1):
        result *= i
        yield result


for el in fact(int(input('Введите число: '))):
    print(el)
