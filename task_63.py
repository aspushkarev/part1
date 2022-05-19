class Worker:

    def __init__(self, surname, name, position, wage, bonus):
        self.name = name
        self.surname = surname
        self.position = position
        self._income = {"Оклад": wage, "Премия": bonus}


class Position(Worker):

    def get_full_name(self):
        return f'Фамилия: {self.surname}\nИмя: {self.name}\nДолжность: {self.position}'

    def get_total_income(self):
        my_dict = employee._income
        income = sum(my_dict.values())
        return f'Доход сотрудника: {income}'


employee = Position('Иванов', 'Сергей', 'Инженер', 34000, 15500)
print(employee.get_full_name())
print(employee.get_total_income())
