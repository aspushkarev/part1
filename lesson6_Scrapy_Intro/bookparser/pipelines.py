# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from pymongo import MongoClient

class BookparserPipeline:
    def __init__(self):
        client = MongoClient('localhost', 27017)
        self.mongobase = client.labirint_books_db

    def process_item(self, item, spider):
        item['base_price'], item['sale_price'], item['rate'] = self.procces_to_int(item['base_price'], item['sale_price'], item['rate'])
        collection = self.mongobase[spider.name]
        collection.insert_one(item)
        return item

    def procces_to_int(self, base_price, sale_price, rate):
        # print()
        if base_price is not None:
            base_price = int(base_price)
        if sale_price is not None:
            sale_price = int(sale_price)
        if rate is not None:
            rate = float(rate)
        return base_price, sale_price, rate
