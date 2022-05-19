from abc import ABC, abstractmethod


class Store(ABC):

    @abstractmethod
    def get_to_store(self):
        pass

    @abstractmethod
    def transmit_to_department(self):
        pass


class NetworkDevice:
    def __init__(self, model, price, color, number_of_store, quantity):
        self.info = {'Модель': model,
                     'Цена': price,
                     'Цвет': color,
                     'Номер склада': number_of_store,
                     'Количество': quantity}

    @staticmethod
    def get_number_printer():
        # Вариант через ValueError
        get_number = 0
        while type:
            number = input('Введите количество принтеров:')
            try:
                get_number = int(number)
            except ValueError:
                print('Введите целое число!')
            else:
                break
        return abs(get_number)

    @staticmethod
    def get_price():
        # Вариант через метод isdigit()
        while True:
            get_price = input('Введите цену:')
            if get_price.isdigit():
                return get_price

    @staticmethod
    def get_number_store():
        # Вариант через метод isdigit()
        while True:
            get_number_store = input('Введите номер склада:')
            if get_number_store.isdigit():
                return get_number_store


class Printer(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, duplex):
        super().__init__(model, price, color, number_of_store, quantity)
        self.duplex = duplex

    @property
    def get_to_store(self):
        return f'Принтер {self.info.setdefault("Модель")} цена {self.info.setdefault("Цена")} ' \
               f'цвет {self.info.setdefault("Цвет")} поступил на склад №{self.info.setdefault("Номер склада")} ' \
               f'в количестве {self.info.setdefault("Количество")} штук.'

    def transmit_to_department(self, department):
        return f'Принтер {self.info.setdefault("Модель")} цена {self.info.setdefault("Цена")} цвет' \
               f' {self.info.setdefault("Цвет")} передан в отдел {department}.'


class Scanner(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, form_scan):
        super().__init__(model, price, color, number_of_store, quantity)
        self.form_scan = form_scan

    @property
    def get_to_store(self):
        return f'Сканер {self.info.setdefault("Модель")} цена {self.info.setdefault("Цена")} ' \
               f'цвет {self.info.setdefault("Цвет")} поступил на склад №{self.info.setdefault("Номер склада")} ' \
               f'в количестве {self.info.setdefault("Количество")} штук.'

    def transmit_to_department(self, department):
        return f'Сканер {self.info.setdefault("Модель")} цена {self.info.setdefault("Цена")} цвет' \
               f' {self.info.setdefault("Цвет")} передан в отдел {department}.'


class Xerox(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, speed_of_copy):
        super().__init__(model, price, color, number_of_store, quantity)
        self.sped_of_copy = speed_of_copy

    @property
    def get_to_store(self):
        return f'Ксерокс {self.info.setdefault("Модель")} цена {self.info.setdefault("Цена")} ' \
               f'цвет {self.info.setdefault("Цвет")} поступил на склад №{self.info.setdefault("Номер склада")} ' \
               f'в количестве {self.info.setdefault("Количество")} штук.'

    def transmit_to_department(self, department):
        return f'Ксерокс {self.info.setdefault("Модель")} цена {self.info.setdefault("Цена")} цвет' \
               f' {self.info.setdefault("Цвет")} передан в отдел {department}.'


m = input('Введите модель:')
p = NetworkDevice.get_price()   # здесь проверка введённой цены
c = input('Введите цвет:')
n = NetworkDevice.get_number_store()   # здесь проверка номера склада
q = NetworkDevice.get_number_printer()   # здесь проверка введённых данных по количеству принтеров
d = input('Печать с двух сторон листа (True/False):')
printer1 = Printer(m, p, c, n, q, d)
printer2 = Printer('Brother', 18300, 'white', 1, 500, True)
print(printer1.get_to_store)
print(printer2.get_to_store)
print(printer1.transmit_to_department('ИТ'))
scanner1 = Scanner('Brother', 12650, 'gray', 2, 347, 'A3')
scanner2 = Scanner('Samsung', 13450, 'white', 2, 328, 'A4')
print(scanner1.get_to_store)
print(scanner2.get_to_store)
print(scanner1.transmit_to_department('персонала'))
xerox1 = Xerox('Xerox', 19990, 'black', 3, 263, 26)
xerox2 = Xerox('Kyocera', 38990, 'white', 3, 25, 35)
print(xerox1.get_to_store)
print(xerox2.get_to_store)
print(xerox1.transmit_to_department('инноваций'))
