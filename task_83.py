class MyTypeError(Exception):
    pass


user_list = input("Введите данные или 'stop' для выхода, а я проверю их на наличие чисел:\n")
user_list = user_list.split(" ")
my_list = []
try:
    while user_list != ['stop']:
        for el in user_list:
            if el.isdigit():
                my_list.append(el)
            else:
                print("Введите только число!")
                # raise MyTypeError("Введите только число")
        user_list = input("Введите данные или 'stop' для выхода, а я проверю их на наличие чисел:\n")
        user_list = user_list.split(" ")
except MyTypeError as error:
    print(error)
finally:
    print("Для меня это просто!")
    print(my_list)
