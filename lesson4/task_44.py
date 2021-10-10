# Представлен список чисел. Определить элементы списка, не имеющие повторений.
# Сформировать итоговый массив чисел, соответствующих требованию.
# Элементы вывести в порядке их следования в исходном списке

def get_unique_number(numbers):
    unique = {}
    for number in numbers:
        if number in unique:
            unique[number] += 1
        else:
            unique[number] = 1
    result = [el for el in numbers if unique[el] == 1]
    return result


numbers = [2, 2, 2, 7, 23, 1, 44, 44, 3, 2, 10, 7, 4, 11]
print(get_unique_number(numbers))
