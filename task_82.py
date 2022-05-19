class MyTypeError(Exception):
    pass


dividend = input("Введите делимое:")
divisor = input("Введите делитель:")
try:
    if int(divisor) == 0:
        raise MyTypeError("Делить на ноль нельзя!")
    result = int(dividend) / int(divisor)
except (ValueError, MyTypeError) as error:
    print(error)
else:
    print(result)
finally:
    print("Деление закончено.")
