class Matrix:

    def __init__(self, my_list):
        self.my_list = my_list

    def __add__(self, other):
        return Matrix([map(sum, zip(*i)) for i in zip(self.my_list, other.my_list)])

    def __str__(self):
        return str('\n'.join(['\t'.join([str(i) for i in j]) for j in self.my_list]))


matrix1 = Matrix([[2, 6, 5], [2, 4, 7], [5, 4, 9]])
print('Первая матрица:\n', matrix1)
matrix2 = Matrix([[2, 3, 7], [2, 8, 1], [3, 4, 3]])
print('Вторая матрица:\n', matrix2)
matrix3 = matrix1 + matrix2
print('Сумма двух матриц:\n', matrix3)
