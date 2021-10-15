#  Представлен список чисел.
#  Необходимо вывести элементы исходного списка, значения которых больше предыдущего элемента

my_list = [300, 2, 12, 44, 1, 1, 4, 10, 7, 1, 78, 123, 55]
end_list = [my_list[num] for num in range(1, len(my_list)) if my_list[num] > my_list[num - 1]]
print(end_list)
