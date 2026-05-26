class Anime:
    def ___init__(self, animeName: str,
                        formatType: str,        # TV, ONA stuff
                        status: str,            # FINISHED, ONGOING
                        episodes: int,
                        coverImage: str,        # A URL of the image
                        averageScore: int,
                 ):
        self.__animeName = animeName
        self.__formatType = formatType
        self.__status = status
        self.__episodes = episodes
        self.__coverImage = coverImage
        self.__averageScore = averageScore

        def getAnimeName(self) -> str:
            return self.__animeName

        def getFormatType(self) -> str:
            return self.__formatType

        def getStatus(self) -> str:
            return self.__status

        def getEpisodes(self) -> int:
            return self.__episodes

        def getCoverImage(self) -> str:
            return self.__coverImage

        def getAverageScore(self) -> int:
            return self.__averageScore

        def setAnimeName(self, animeName: str):
            self.__animeName = animeName

        def setFormatType(self, formatType: str):
            self.__formatType = formatType

        def setStatus(self, status: str):
            self.__status = status

        def setEpisodes(self, episodes: int):
            self.__episodes = episodes

        def setCoverImage(self, coverImage: str):
            self.__coverImage = coverImage

        def setAverageScore(self, averageScore: int):
            self.__averageScore = averageScore

