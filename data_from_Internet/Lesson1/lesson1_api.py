import json
import requests

url = "https://api.github.com/users/aspushkarev/repos?direction=asc"

response = requests.get(url)
json_data = response.json()

with open('data.json', 'w', encoding="UTF-8") as f:
    json.dump(json_data, f)

for i in json_data:
    print(i['name'])
