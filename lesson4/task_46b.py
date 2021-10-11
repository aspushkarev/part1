# итератор, повторяющий элементы некоторого списка, определенного заранее
from itertools import cycle

my_list = [1, 'text', {1: 'A', 2: 'B', 3: 'C'}]
score = 1
for el in cycle(my_list):
    if score > 13:
        break
    print(el)
    score += 1
