class Cell:

    def __init__(self, count_cell):
        # print("Создаю клетку")
        self.count_cell = count_cell

    def __str__(self):
        return f'{self.count_cell}'

    def __add__(self, other):
        print('Сумма клеток:')
        return Cell(self.count_cell + other.count_cell)

    def __sub__(self, other):
        if self.count_cell < other.count_cell:
            raise ValueError("Не могу отнять клетки")
        print('Вычитание клеток:')
        return Cell(self.count_cell - other.count_cell)

    def __mul__(self, other):
        print('Умножение клеток:')
        return Cell(self.count_cell * other.count_cell)

    def __truediv__(self, other):
        print('Деление клеток:')
        return Cell(int(self.count_cell / other.count_cell))

    def make_order(self, row_len):
        result = ['*' * row_len * (self.count_cell // row_len)]
        if self.count_cell % row_len:
            result.append('*' * (self.count_cell % row_len))
        return '\n'.join(result)


cell1 = Cell(19)
cell2 = Cell(9)
print(cell1 + cell2)
print(cell1 - cell2)
print(cell1 * cell2)
print(cell1 / cell2)
print(cell1.make_order(3))
print(cell2.make_order(4))
