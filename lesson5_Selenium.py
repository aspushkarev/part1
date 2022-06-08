import time
from pprint import pprint

from pymongo import MongoClient
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

s = Service('./chromedriver')
options = Options()
options.add_argument('start-maximized')

driver = webdriver.Chrome(service=s, options=options)
driver.implicitly_wait(10)
driver.get("https://account.mail.ru/login")

client = MongoClient('127.0.0.1', 27017)
db = client['letters_db']
letters = db.letters

db.letters.drop()

input_name = driver.find_element(By.XPATH, "//input[contains(@name, 'username')]")
input_name.send_keys("study.ai_172@mail.ru")
input_name.send_keys(Keys.ENTER)

input_password = driver.find_element(By.XPATH, "//input[contains(@name, 'password')]")
input_password.send_keys("NextPassword172#")
input_password.send_keys(Keys.ENTER)

# First - collection the link to letters. Use set() for it
print('Searching letters in the box. This take few minutes.')
all_link = set()
len_all_link = 1
while True:
    if len(all_link) == len_all_link:   # Как только ссылки не будут добавляться в множество, их длины сравняются
        break
    else:
        len_all_link = len(all_link)
        contents = driver.find_elements(By.CLASS_NAME, 'llc')
        for letter in contents:
            href = letter.get_attribute("href")
            all_link.add(href)

        # Then scrolling
        actions = ActionChains(driver)
        actions.move_to_element(contents[-1])
        actions.perform()

        time.sleep(1)

print(f'Number of letters in a box {len(all_link)} pieces')
# pprint(all_link)

# Second - extracting data from e-mails
print('Extracting data from letters. This take few minutes. Please, wait...')
list_letter = []
for url in all_link:
    item_letter = {}
    driver.get(url)

    from_letter = driver.find_element(By.XPATH, ".//div[@class='letter__author']/span").accessible_name
    data_letter = driver.find_element(By.XPATH, ".//div[@class='letter__date']").text
    title_letter = driver.find_element(By.XPATH, ".//h2[@class='thread-subject']").text
    text_letter = driver.find_element(By.XPATH, ".//div[@class='letter__body']").text

    item_letter['from_letter'] = from_letter
    item_letter['data_letter'] = data_letter
    item_letter['title_letter'] = title_letter
    item_letter['text_letter'] = text_letter

    list_letter.append(item_letter)
    time.sleep(1)

# pprint(list_letter)
driver.close()

# Third - adds data to MongoDB
print('Adding data to db...')
for i in range(len(list_letter)):
    letters.insert_one(list_letter[i])
pprint(list_letter)
