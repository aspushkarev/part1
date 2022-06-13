import scrapy
from scrapy.http import HtmlResponse
from bookparser.items import BookparserItem

class LabirintruSpider(scrapy.Spider):
    name = 'labirintru'
    allowed_domains = ['labirint.ru']
    start_urls = ['https://www.labirint.ru/search/сказки/?stype=0']

    def parse(self, response:HtmlResponse):
        # button = response.xpath("//button[contains(text(),'Принять')]")
        # button.click()
        the_url = 'https://www.labirint.ru'
        next_page = response.xpath("//a[@class='pagination-next__text']/@href").get()
        if next_page:
            yield response.follow(next_page, callback=self.parse)

        links = response.xpath("//a[@class='product-title-link']/@href").getall()
        for link in links:
            yield response.follow(the_url + link, callback=self.parse_book)

    def parse_book(self, response:HtmlResponse):
        name = response.css("h1::text").get()
        author = response.xpath("//a[@data-event-label='author']//text()").get()
        url = response.url
        base_price = response.xpath("//span[@class='buying-priceold-val-number']/text()").get()
        sale_price = response.xpath("//span[@class='buying-pricenew-val-number']/text()").get()
        rate = response.xpath("//div[@id='rate']/text()").get()
        yield BookparserItem(name=name, author=author, url=url, base_price=base_price, sale_price=sale_price, rate=rate)
