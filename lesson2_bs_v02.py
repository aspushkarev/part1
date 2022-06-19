from pprint import pprint

import requests
from bs4 import BeautifulSoup as bs

main_url = "https://hh.ru"
params = {'search_field': ['name', 'company_name', 'description'], 'text': 'data scientist'}
headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 \
            (KHTML, like Gecko) Chrome/102.0.5005.61 Safari/537.36'}

# response = requests.get(main_url + '/search/vacancy', params=params, headers=headers)
# # print(response.url)
# with open('page.html', 'w', encoding='utf-8') as f:
#     f.write(response.text)

all_vacancies = []
pager_next = ' '
while pager_next is not None:

    if pager_next == ' ':
        response = requests.get(main_url + '/search/vacancy', params=params, headers=headers)
    else:
        response = requests.get(pager_next, headers=headers)
    # print(response.url)

    with open('page.html', 'w', encoding='utf-8') as f:
        f.write(response.text)

    with open('page.html', 'r', encoding='utf-8') as f:
        html = f.read()

    soup = bs(html, 'html.parser')

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

pprint(all_vacancies)
print(f'The count of all vacancies:', len(all_vacancies))
