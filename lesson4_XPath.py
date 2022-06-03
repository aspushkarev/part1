import copy
from pprint import pprint

import requests
from lxml import html
from pymongo import MongoClient
from pymongo.errors import DuplicateKeyError as dke


def scraping_news(url, headers):
    """
    This function scraping news from internet https://yandex.ru/news
    :param url: URL for searching
    :param headers: Headers User-Agent from your browser
    :return: List of news
    """

    response = requests.get(url, headers=headers)
    dom = html.fromstring(response.text)
    box_news = dom.xpath(
        "//div[contains(@class,'mg-grid__col mg-grid__col_xs_4')] | //div[contains(@class,'mg-grid__col mg-grid__col_xs_6')]")

    list_news = []
    for box in box_news:
        item_news = {}

        name_of_source = box.xpath(".//a[@class='mg-card__source-link']/text()")
        name_of_tne_news = box.xpath(".//h2[@class='mg-card__title']/a/text()")
        link_to_news = box.xpath(".//h2[@class='mg-card__title']/a/@href")
        date_of_publication = box.xpath(".//span[@class='mg-card-source__time']/text()")

        name_of_tne_news = str(name_of_tne_news)
        name_of_tne_news = name_of_tne_news.replace('\\xa0', ' ')

        item_news['name_of_source'] = name_of_source
        item_news['name_of_tne_news'] = name_of_tne_news
        item_news['link_to_news'] = link_to_news
        item_news['date_of_publication'] = date_of_publication

        list_news.append(item_news)

    return list_news


def edit_news(list_news):
    """
    This function deletes empty dictionaries in list
    :param list_news: List to edit
    :return: Returns edited list of news
    """
    # Delete empty dictionary
    new_list_news = []
    for el in list_news:
        if len(el['link_to_news']) == 0:
            del el
        else:
            new_list_news.append(el)

    return new_list_news


def add_news_to_db(list_news):
    """
    This function adds news to MongoDB
    :param list_news: This is list of news which to be add to MongoDB
    :return: Returns list of news from collection 'news' from MongoDB
    """
    print('Start add a news to db...')
    for i in range(len(list_news)):
        try:
            if news.find_one({'link_to_news': list_news[i]['link_to_news']}):
                print('This document exists in the collection.')
            else:
                news.insert_one(list_news[i])
        except dke:
            print(f'Duplicate in the document {i}')
    pprint(list_news)


url = "https://yandex.ru/news"
headers = {'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) \
            Chrome/102.0.0.0 Safari/537.36'}

client = MongoClient('127.0.0.1', 27017)
db = client['news_db']
news = db.news

list_news = scraping_news(url, headers)
# pprint(edit_news(list_news))
edit_news = edit_news(list_news)
# pprint(edit_news)
add_news_to_db(edit_news)

result = news.count_documents({})
print(f'The count of the documents in "news" collection is {result}')
