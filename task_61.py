import time


class TrafficLight:

    def running(self):
        self.__color = "Красный"
        print(f'{self.__color}')
        time.sleep(7)
        self.__color = "Жёлтый"
        print(f'{self.__color}')
        time.sleep(2)
        self.__color = "Зелёный"
        print(f'{self.__color}')
        time.sleep(15)


tl = TrafficLight()
tl.running()
