class Road:

    def __init__(self, length, width):
        self._length = length
        self._width = width

    def calculating(self, mass_asf=25, num=5):
        return f'Масса асфальта: {(self._length * self._width * mass_asf * num) / 1000} тонн'


r = Road(5000, 20)
print(r.calculating())
