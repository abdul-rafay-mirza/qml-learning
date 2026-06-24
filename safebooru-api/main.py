import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal
import requests
import difflib
import json

# 1. Define a backend class that QML can interact with
class Backend(QObject):
    getResponse = Signal(list)

    def __init__(self, engine):
        super().__init__()
        self.engine = engine

    def get_window(self):
        root_objects = self.engine.rootObjects()
        if root_objects:
            return root_objects[0]
        return None

    @Slot(str)
    def get_search_query(self, search_query):
        window = self.get_window()
        if window:
            print(f"User searched: {search_query}")

            fixed_search_tag = self.get_fuzzy_tag(search_query)
            print(f"Fixed: {fixed_search_tag}")

            url = "https://safebooru.org/index.php"
            query_params = {
                "page": "dapi",
                "s": "post",
                "q": "index",
                "json": 1,            # Force Safebooru to give us clean Python dictionaries
                "tags": fixed_search_tag,
                "limit": 10            # Only pull 10 images
            }

            try:
                response = requests.get(url, params=query_params)
                if response.status_code == 200:
                    posts = response.json()
                    print("Safebooru Images Found:")
                    # print(posts)

                    myFile = open("response.json", "w")
                    json.dump(posts, myFile, indent=4)
                    myFile.close()

                    # print(type(posts)) # <class 'list'>

                    image_links: list[dict] = []
                    for dictionaries in posts:
                        image_links.append(dictionaries["file_url"])

                    # print(image_links)
                    self.getResponse.emit(image_links)

                else:
                    print(f"Safebooru responded with error code: {response.status_code}")
            except Exception as e:
                print(f"Failed to fetch from Safebooru: {e}")

            

    def get_fuzzy_tag(self, user_input):
            POPULAR_TAGS = [
                "ganyu_(genshin_impact)", "furina_(genshin_impact)", "raiden_shogun", 
                "hu_tao_(genshin_impact)", "kamisato_ayaka", "hatsune_miku", 
                "rem_(re:zero)", "emilia_(re:zero)", "klee_(genshin_impact)"
            ]

            user_input = user_input.strip().lower()
            
            # 1. Direct Substring Match (Fixes "ganyu" -> "ganyu_(genshin_impact)")
            for tag in POPULAR_TAGS:
                if user_input in tag:
                    print(f"🎯 Substring match found: '{user_input}' -> '{tag}'")
                    return tag

            # 2. Cleaned Typo Match (Fixes "gnayu" -> "ganyu_(genshin_impact)")
            # Maps short names to full tags: {'ganyu': 'ganyu_(genshin_impact)', 'furina': ...}
            cleaned_tags = {tag.split("_(")[0]: tag for tag in POPULAR_TAGS}
            
            matches = difflib.get_close_matches(user_input, list(cleaned_tags.keys()), n=1, cutoff=0.5)
            
            if matches:
                actual_tag = cleaned_tags[matches[0]]
                print(f"💡 Autocorrected typo '{user_input}' to '{actual_tag}'")
                return actual_tag
                
            return user_input # Fallback if totally unrecognizable

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # 2. Instantiate the backend
    backend = Backend(engine)

    # 3. Expose the Python object to QML's context
    # This allows QML to use the variable name 'backend'
    engine.rootContext().setContextProperty("backend", backend)

    # 4. Load the QML file
    qml_file = Path(__file__).resolve().parent / "Main.qml"
    engine.load(str(qml_file))

    # Check if the QML file loaded successfully
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())