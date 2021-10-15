# Необходимо создать (не программно) текстовый файл, где каждая строка описывает учебный предмет
# и наличие лекционных, практических и лабораторных занятий по этому предмету и их количество.
# Важно, чтобы для каждого предмета не обязательно были все типы занятий. Сформировать словарь,
# содержащий название предмета и общее количество занятий по нему. Вывести словарь на экран.
my_dict = dict()
with open("subject_matter.txt", "r") as f:
    for line in f:
        subject, hours = line.split(':')
        hours = hours.split()
        amount = 0
        for part in hours:
            if "-" in part:
                continue
            number, types = part.split('(')
            amount += int(number)
            my_dict[subject] = amount
print(my_dict)
