class Data:
    def __init__(self, str_date):
        self.str_date = str_date
        print("Инициализатор")

    @classmethod
    def get_data(cls, str_date):
        date, month, year = str_date.split('-')
        return int(date), int(month), int(year)

    @staticmethod
    def to_validate_data(date, month, year):
        print("Начинаю проверку чисел.")
        if date < 0 or date > 31:
            print("Неправильно введена дата!")
        if month < 0 or month > 12:
            print("Неправильно введён месяц!")
        if year < 0 or year > 9999:
            print("Неверно введён год!")


data = Data('12-03-2021')
print(Data.get_data('12-03-2021'))
Data.to_validate_data(37, 4, 2021)
Data.to_validate_data(12, -4, 99990)
