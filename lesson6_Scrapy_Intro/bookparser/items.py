# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class BookparserItem(scrapy.Item):
    # define the fields for your item here like:
    name = scrapy.Field()
    author = scrapy.Field()
    url = scrapy.Field()
    base_price = scrapy.Field()
    sale_price = scrapy.Field()
    rate = scrapy.Field()
    _id = scrapy.Field()

