# Создать (не программно) текстовый файл, в котором каждая строка должна содержать данные о фирме:
# название, форма собственности, выручка, издержки.
# Необходимо построчно прочитать файл, вычислить прибыль каждой компании, а также среднюю прибыль.
# Если фирма получила убытки, в расчет средней прибыли ее не включать
# Далее реализовать список. Он должен содержать словарь с фирмами и их прибылями, а также словарь со средней
# прибылью. Если фирма получила убытки, также добавить ее в словарь (со значением убытков)
# Итоговый список сохранить в виде json-объекта в соответствующий файл
import json

dict_firm = dict()
average_profit = 0
count = 0
with open("firms.txt", "r") as f:
    for line in f:
        name, form, income, expenses = line.split()
        profit = int(income) - int(expenses)
        if profit >= 0:
            average_profit += profit
            count += 1
        dict_firm[name] = profit
average_profit /= count
with open("firms.json", "w", encoding='utf-8') as f:
    json.dump([dict_firm, {"Средняя прибыль": average_profit}], f, ensure_ascii=False, indent=2)
