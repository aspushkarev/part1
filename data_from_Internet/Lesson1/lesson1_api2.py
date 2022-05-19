import requests

url = "https://api.vk.com/method/groups.get?v=5.131&access_token=21e89452b3e277aaa8e786a8273921fbfdae939f5c1d54f55d1624b147e443b75a98274d146610700d8a6"

response = requests.get(url)
json_data = response.json()

print(f'List of all groups:', json_data['response']['items'])
