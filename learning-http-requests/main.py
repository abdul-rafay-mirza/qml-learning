import requests
import json

url = "https://graphql.anilist.co"

query = '''
query ($id: Int) {
  Media(id: $id, type: ANIME) {
    id
    title {
      romaji
      english
      native
    }
    nextAiringEpisode {
      airingAt
      timeUntilAiring
      episode
    }
    format
    episodes
    duration
    status
    startDate {
      day
      month
      year
    }
    endDate {
      day
      month
      year
    }
    averageScore
    meanScore
    popularity
    favourites
    studios {
      nodes {
        name
        isAnimationStudio
      }
    }
    source
    hashtag
    genres
    synonyms
    tags {
      name
      rank
      isMediaSpoiler
    }
    externalLinks {
      site
      url
    }
    bannerImage
    coverImage {
      large
    }
    description
    relations {
      edges {
        relationType(version: 2)
        node {
          id
          type
          format
          title {
            romaji
            english
          }
          coverImage {
            large
          }
          status
        }
      }
    }
    characters(sort: [FAVOURITES_DESC, ROLE], perPage: 6) {
      edges {
        role
        node {
          id
          name {
            full
            native
          }
          image {
            large
          }
        }
      }
    }
    staff(sort: [FAVOURITES_DESC, ROLE], perPage: 6) {
      edges {
        role
        node {
          id
          name {
            full
            native
          }
          image {
            large
          }
        }
      }
    }
    recommendations(sort: [RATING_DESC], perPage: 7) {
      nodes {
        mediaRecommendation {
          title {
            english
            native
            romaji
          }
          coverImage {
            large
          }
        }
      }
    }
  }
}
'''

variables = {
    'id': 147105
}

dictToPass = {
    "query": query,
    "variables": variables
}

response = requests.post(url, json=dictToPass)

json_object: dict = response.json()

myFile = open("anime_request.json", "w")
json.dump(response.json(), myFile, indent = 4)
myFile.close()

print(json_object["data"]["Media"]["title"]["romaji"])
