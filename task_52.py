# Создать текстовый файл (не программно), сохранить в нем несколько строк,
# выполнить подсчет количества строк, количества слов в каждой строке

file = open("file2.txt", "r")
# Вычисляем количество строк в файле
content = file.read().splitlines()
print('Количество строк в файле:', len(content))
file.seek(0)
# Вычисляем количество слов в строке
i = 1
for line in content:
    content_line = file.readline()
    word = content_line.split()
    counter = len(word)
    print(f'Количество слов в строке №{i}:', counter)
    i += 1
file.close()
