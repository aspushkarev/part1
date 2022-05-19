from abc import ABC, abstractmethod


class Clothes(ABC):
    expense_count = 0

    @abstractmethod
    def expense(self):
        pass


class Coat(Clothes):
    def __init__(self, size):
        self.size = size
        Coat.expense_count += self.expense

    def __str__(self):
        return f'Пальто: размер {self.size}, расход ткани {self.expense}, ' \
               f'общий расход ткани {Coat.expense_count:.02f}'

    @property
    def expense(self):
        expense = self.size / 6.5 + 0.5
        return float(f'{expense:.02f}')


class Suit(Clothes):
    def __init__(self, height):
        self.height = height
        Suit.expense_count += self.expense

    def __str__(self):
        return f'Костюм: размер {self.height}, расход ткани {self.expense}, ' \
               f'общий расход ткани {Suit.expense_count:.02f}'

    @property
    def expense(self):
        expense = (self.height * 2 + 0.3) / 100
        return float(f'{expense:.02f}')


coat1 = Coat(48)
print(coat1)
coat2 = Coat(50)
print(coat2)
suit1 = Suit(190)
print(suit1)
suit2 = Suit(180)
print(suit2)
