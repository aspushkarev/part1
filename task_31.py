def my_partition(dividend, divide):
    """
    Функция выполняет деление.

    Позиционные аргументы:
    dividend - делимое
    divide - делитель

    Функция возвращает частное от деления.
    """
    try:
        return int(dividend) / int(divide)
    except ZeroDivisionError:
        print("На ноль делить нельзя!")
    except ValueError:
        print("Вы должны ввести целое число")


dividend = input('Введите делимое: ')
divide = input('Введите делитель: ')

print("Ответ: ", my_partition(dividend, divide))
