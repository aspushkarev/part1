from pprint import pprint

import requests
from bs4 import BeautifulSoup as bs
from pymongo import MongoClient
from pymongo.errors import DuplicateKeyError as dke


def scraping_vacancies(main_url, params, headers):
    all_vacancies = []
    pager_next = ' '
    while pager_next is not None:

        if pager_next == ' ':
            response = requests.get(main_url + '/search/vacancy', params=params, headers=headers)
            # print(response.url)
            print('Scraping in processing...Please wait')
        else:
            response = requests.get(pager_next, headers=headers)

        soup = bs(response.text, 'html.parser')

        vacancies = soup.find_all(class_='vacancy-serp-item')

        for vacancy in vacancies:
            vacancy_info = {}
            vacancy_salary = {}
            vacancy_data = {}

            vacancy_anchor = vacancy.find('a', {'data-qa': 'vacancy-serp__vacancy-title'})
            vacancy_name = vacancy_anchor.getText()
            vacancy_link = vacancy_anchor['href']
            vacancy_salary_info = vacancy.find('span', {'data-qa': 'vacancy-serp__vacancy-compensation'})

            if vacancy_salary_info is None:
                vacancy_info['min'] = None
                vacancy_info['max'] = None
                vacancy_info['currency'] = None
            else:
                salary = vacancy_salary_info.text.replace('\u202f', '')
                split_salary = salary.split()
                if split_salary[0] == 'от':
                    vacancy_info['min'] = int(split_salary[1])
                    vacancy_info['max'] = None
                    vacancy_info['currency'] = split_salary[2]
                elif split_salary[0] == 'до':
                    vacancy_info['min'] = None
                    vacancy_info['max'] = int(split_salary[1])
                    vacancy_info['currency'] = split_salary[2]
                else:
                    vacancy_info['min'] = int(split_salary[0])
                    vacancy_info['max'] = int(split_salary[2])
                    vacancy_info['currency'] = split_salary[3]

            vacancy_salary.update(vacancy_info)

            vacancy_data['name'] = vacancy_name
            vacancy_data['salary'] = vacancy_salary
            vacancy_data['link'] = vacancy_link
            vacancy_data['url'] = main_url

            all_vacancies.append(vacancy_data)

            find_a = soup.find('a', {'data-qa': 'pager-next'})
            if find_a is None:
                pager_next = None
            else:
                pager = find_a['href']
                pager_next = main_url + pager

    # pprint(all_vacancies)
    print(f'The count of all found a vacancies is', len(all_vacancies))

    return all_vacancies


def add_new_vacancy(all_vacancies):
    print('Start add a vacancies...')
    for vacancy in range(len(all_vacancies)):
        try:
            if vacancies.find_one({'link': all_vacancies[vacancy]['link']}):
                print('The document exists in the collection.')
            else:
                vacancies.insert_one(all_vacancies[vacancy])
        except dke:
            print(f'Duplicate in the document {vacancy}')
    pprint(all_vacancies)


def find_vacancies(salary):
    print(f'The result of searching the vacancies with salary more than {salary}:')
    for document in vacancies.find({'$or': [{'salary.min': {'$gte': salary}}, {'salary.max': {'$gte': salary}}]}):
        pprint(document)
    result = vacancies.count_documents({'$or': [{'salary.min': {'$gte': salary}}, {'salary.max': {'$gte': salary}}]})
    print(f'The count of found the documents is {result}')


your_word = input('Type a vacancy for searching: ')

main_url = "https://hh.ru"
params = {'search_field': ['name', 'company_name', 'description'], 'items_on_page': 20, 'text': {your_word}}
headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 \
            (KHTML, like Gecko) Chrome/102.0.5005.61 Safari/537.36'}

client = MongoClient('127.0.0.1', 27017)
db = client['vacancies_db']
vacancies = db.vacancies

all_vacancies = scraping_vacancies(main_url, params, headers)

# vacancies.delete_many({})
# db.drop_collection('vacancies')

add_new_vacancy(all_vacancies)

score = vacancies.count_documents({})
print(f'In the collection vacancies is {score} documents.')

# find_vacancies(300000)  # searching for vacancies more than 300000
# find_vacancies(370000)  # searching for vacancies more than 370000
# find_vacancies(500000)  # searching for vacancies more than 500000
