import requests
import json
import os
import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtQuickControls2 import QQuickStyle

class Backend(QObject):
    animePageLoaded = Signal(str, str)
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

    def __init__(self, engine):
        super().__init__()
        self.engine = engine

    def get_window(self):
        root_objects = self.engine.rootObjects()
        if root_objects:
            return root_objects[0]
        return None

    @Slot()
    def _load(self):
        window = self.get_window()
        if window:
          response = requests.post(self.url, json=self.dictToPass)

          json_file = response.json()

          myFile = open("anime_request.json", "w")
          json.dump(json_file, myFile, indent = 4)
          myFile.close()

          title = json_file["data"]["Media"]["title"]["romaji"]
          bannerImage = json_file["data"]["Media"]["bannerImage"]

          self.animePageLoaded.emit(title, bannerImage)

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    
    # Switch to the Breeze framework engine or else tick marks don't appear for some reason
    QQuickStyle.setStyle("org.kde.desktop")

    engine = QQmlApplicationEngine()

    backend = Backend(engine)
    engine.rootContext().setContextProperty("backend", backend)

    # 1. Define a function that runs exactly when the engine finishes building the window
    def on_object_created(obj, obj_url):
        if obj is None:
            sys.exit(-1)
        # 2. Call your loading method here!
        backend._load()

    # 3. Connect the signal to your function BEFORE loading the QML
    engine.objectCreated.connect(on_object_created)

    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(str(qml_file))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())

