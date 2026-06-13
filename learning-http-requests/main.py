import requests
import json

url = "https://graphql.anilist.co"

query = '''
query ($id: Int) {
  Media (id: $id, type: ANIME) {
    id
    title {
      romaji
      english
      native
    }
  }
}
'''

variables = {
    'id': 189046
}

dictToPass = {
    "query": query,
    "variables": variables
}

response = requests.post(url, json=dictToPass)

to_dict: dict = json.loads(response.text)

myFile = open("anime_request.json", "w")
json.dump(to_dict, myFile, indent = 4)
myFile.close()

print(to_dict["data"]["Media"]["title"]["romaji"])
