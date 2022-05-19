# Создать текстовый файл (не программно). Построчно записать фамилии сотрудников и величину их окладов
# (не менее 10 строк). Определить, кто из сотрудников имеет оклад менее 20 тысяч,
# вывести фамилии этих сотрудников. Выполнить подсчёт средней величины дохода сотрудников

f = open("salary.txt", "r")
stuff = f.read()
stuff = stuff.split()
list_name = [stuff[el] for el in range(0, len(stuff), 2)]
list_salary = [stuff[el] for el in range(1, len(stuff), 2)]
stuff_dict = dict(zip(list_name, list_salary))
# фильтруем словарь по зарплате менее 20000
low_salary_dict = {key: value for key, value in stuff_dict.items() if float(value) < 20000}
# Печатаем фамилии, у кого зарплата менее 20000
print('Сотрудники с зарплатой менее 20000: ')
for key in low_salary_dict:
    print(key)
# Ищем средний доход всех сотрудников
sum_salary = 0
for value in stuff_dict.values():
    sum_salary = sum_salary + float(value)
average_salary = sum_salary / len(stuff_dict)
print('Средняя зарплата сотрудников:\n%.2f' % average_salary)
f.close()
