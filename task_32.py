def data_citizen(name, surname, born, city, email, phone):
    """
    Функция принимает параметры, описывающие данные пользователя.

    Позиционные аргументы:
    name:    Имя пользователя
    surname: Фамилия пользователя
    born:    Дата рождения
    city:    Город проживания
    email:   e-mail
    phone:   Номер телефона

    Выводит данные одной строкой.
    """

    return f"Имя {name}, фамилия {surname},дата рождения {born}, город проживания {city}, Email {email}, телефон {phone}"


print(data_citizen(name="Alexander", surname="Ivanov", born="28.04.1983", city="Nsk", email="mail@list.ru",
                   phone="+7-999-999-99-99"))
