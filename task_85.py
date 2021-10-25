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
        self.model = model
        self._price = price
        self.color = color
        self.number_of_store = number_of_store
        self.quantity = quantity


class Printer(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, duplex):
        super().__init__(model, price, color, number_of_store, quantity)
        self.duplex = duplex

    @property
    def get_to_store(self):
        return f'Принтер {self.model} цена {self._price} цвет {self.color} поступил на склад №{self.number_of_store}' \
               f' в количестве {self.quantity} штук.'

    def transmit_to_department(self, department):
        return f'Принтер {self.model} цена {self._price} цвет {self.color} передан в отдел {department}.'


class Scanner(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, form_scan):
        super().__init__(model, price, color, number_of_store, quantity)
        self.form_scan = form_scan

    @property
    def get_to_store(self):
        return f'Сканер {self.model} цена {self._price} цвет {self.color} поступил на склад №{self.number_of_store}' \
               f' в количестве {self.quantity} штук.'

    def transmit_to_department(self, department):
        return f'Сканер {self.model} цена {self._price} цвет {self.color} передан в отдел {department}.'


class Xerox(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, speed_of_copy):
        super().__init__(model, price, color, number_of_store, quantity)
        self.sped_of_copy = speed_of_copy

    @property
    def get_to_store(self):
        return f'Ксерокс {self.model} цена {self._price} цвет {self.color} поступил на склад №{self.number_of_store}' \
               f' в количестве {self.quantity} штук.'

    def transmit_to_department(self, department):
        return f'Ксерокс {self.model} цена {self._price} цвет {self.color} передан в отдел {department}.'


printer1 = Printer('HP', 15400, 'black', 1, 500, True)
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
