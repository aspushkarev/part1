class Stationery:

    def __init__(self, title):
        self.title = title

    def draw(self):
        print('Запуск отрисовки')


class Pen(Stationery):
    def draw(self):
        print(f'Рисую {self.title}')


class Pencil(Stationery):
    def draw(self):
        print(f'Рисую {self.title}')


class Handle(Stationery):
    def draw(self):
        print(f'Рисую {self.title}')


pen1 = Stationery('Нечто')
pen1.draw()
pen = Pen('Ручка')
pencil = Pencil('Карандаш')
handle = Handle('Маркер')
pen.draw()
pencil.draw()
handle.draw()

