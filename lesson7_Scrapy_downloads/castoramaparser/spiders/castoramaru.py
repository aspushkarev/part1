import scrapy
from scrapy.http import HtmlResponse
from castoramaparser.items import CastoramaparserItem
from scrapy.loader import ItemLoader

class CastoramaruSpider(scrapy.Spider):
    name = 'castoramaru'
    allowed_domains = ['castorama.ru']
    start_urls = ['https://www.castorama.ru/gardening-and-outdoor/swimming-pools/swimming-pools']

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def parse(self, response: HtmlResponse):
        next_page = response.xpath("//a[@class='next i-next']/@href[1]").get()
        if next_page:
            yield response.follow(next_page, callback=self.parse)
        links = response.xpath("//a[@class='product-card__name ga-product-card-name']")
        for link in links:
            yield response.follow(link, callback=self.parse_ads)

    def parse_ads(self, response: HtmlResponse):
        loader = ItemLoader(item=CastoramaparserItem(), response=response)
        loader.add_xpath('name', '//h1/text()')
        loader.add_xpath('price', "(//span[@class='currency']/../span[1])[1]/text()")
        loader.add_xpath('photos', "//li[contains(@class, 'top-slide swiper-slide')]/div/img/@data-src")
        loader.add_value('url', response.url)
        yield loader.load_item()
