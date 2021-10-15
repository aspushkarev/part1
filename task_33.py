def my_func(num1, num2, num3):
    """
    Функция принимает три позиционных аргумента.

    num1:   первый аргумент
    num2:   второй аргумент
    num3:   третий аргумент

    Функция возвращает сумму наибольших двух аргументов.
    """

    try:
        my_list = sorted([int(num1), int(num2), int(num3)])
        return my_list[1] + my_list[2]
    except ValueError:
        print('Введите только цифры')


print("Сумма наибольших двух чисел равна: ", my_func(input("Число a:"), input("Число b:"), input("Число c:")))
