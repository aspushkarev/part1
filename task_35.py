# Программа запрашивает у пользователя строку чисел, разделенных пробелом.
# При нажатии Enter должна выводиться сумма чисел. Пользователь может продолжить ввод чисел,
# пока не будет введён специальный символ 'Q'

def my_func():
    score = 0
    flag = True
    while flag:
        list_user = input('Введите строку чисел через пробел или Q для выхода: ').upper().split()
        for i in list_user:
            if i == 'Q':
                flag = False
                break
            try:
                score += int(i)
            except ValueError:
                pass
        print(f'Сумма чисел равна {score}')


my_func()