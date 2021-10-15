# Скрипт расчёта заработной платы сотрудника

from sys import argv

hours, rate, bonus = argv[1:]
salary = int(hours) * int(rate) + int(bonus)
print(f'Зарплата сотрудника: {salary}')
