class Store:
    pass


class NetworkDevice:
    def __init__(self, model, price, color, number_of_store, quantity):
        self.model = model
        self.price = price
        self.color = color
        self.number_of_store = number_of_store
        self.quantity = quantity


class Printer(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, duplex):
        super().__init__(model, price, color, number_of_store, quantity)
        self.duplex = duplex


class Scanner(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, form_scan):
        super().__init__(model, price, color, number_of_store, quantity)
        self.form_scan = form_scan


class Xerox(NetworkDevice):
    def __init__(self, model, price, color, number_of_store, quantity, speed_of_copy):
        super().__init__(model, price, color, number_of_store, quantity)
        self.sped_of_copy = speed_of_copy


printer1 = Printer('HP', 15400, 'black', 1, 500, True)
scanner1 = Scanner('Brother', 12650, 'gray', 2, 347, 'A3')
xerox1 = Xerox('Xerox', 19990, 'black', 3, 263, 26)
