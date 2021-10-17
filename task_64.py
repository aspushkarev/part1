class Car:
    is_police = False

    def __init__(self, speed, color, name):
        self.speed = speed
        self.color = color
        self.name = name
        print(f'Новая машина: {self.name}, цвет {self.color}.')
        if self.is_police is True:
            print(f'Машина полицейская')

    def go(self, speed=20):
        self.speed = speed
        print(f'Машина {self.name}, цвет {self.color} поехала!')

    def stop(self):
        self.speed = 0
        print(f'Машина {self.name}, цвет {self.color} остановилась!')

    def turn(self, direction):
        print(f'Машина {self.name}, цвет {self.color} повернула {"налево" if direction == 0 else "направо"}')

    def show_speed(self):
        return f'Текущая скорость {self.name}: {self.speed}'


class TownCar(Car):

    def show_speed(self):
        return f'Машина {self.name}, скорость {self.speed}. Превышение скорости!' \
            if self.speed > 60 else f'Машина {self.name}, скорость {self.speed}'


class SportCar(Car):
    pass


class WorkCar(Car):

    def show_speed(self):
        return f'Машина {self.name}, скорость {self.speed}. Превышение скорости!' \
            if self.speed > 40 else f'Машина {self.name}, скорость {self.speed}'


class PoliceCar(Car):
    is_police = True


car1 = PoliceCar(240, 'Black', 'Mustang')
car1.go()
print(car1.show_speed())
car1.turn(40)
car1.stop()
car2 = WorkCar(45, 'Orange', 'Камаз')
car2.go()
print(car2.show_speed())
car2.turn(0)
car2.stop()
car3 = SportCar(310, 'Red', 'Ferrari')
car3.go()
print(car3.show_speed())
car3.turn(0)
car3.stop()
car4 = TownCar(110, 'Grey', 'Kia')
car4.go()
print(car4.show_speed())
car4.turn(0)
car4.stop()
