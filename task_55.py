# Создать (программно) текстовый файл, записать в него программно набор чисел,
# разделенных пробелами. Программа должна подсчитывать сумму чисел в файле и выводить ее на экран

# Создаём файл и записываем данные
file = open("file_sum.txt", "w", encoding='utf-8')
file.write(input('Введите числа через пробел: '))
file.close()
# Открываем файл на чтение
file = open("file_sum.txt", "r", encoding='utf-8')
content = file.read().splitlines()
# Сдвигаем курсор на начало файла
file.seek(0)
# Разделяем содержимое списка
content = content[0].split(" ")
# Подсчитываем суммы чисел
s = 0
for el in content:
    s += int(el)
print(f'Сумма чисел в строке: {s}')
file.close()
