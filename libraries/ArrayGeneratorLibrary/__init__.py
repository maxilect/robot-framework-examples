from random import randint
from typing import List

from robot.api.deco import keyword


class ArrayGeneratorLibrary:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    @keyword("Генерировать массив чисел")
    def generate_array(self, length: int, minimal: int, maximal: int) -> List[int]:
        result = []
        for i in range(int(length)):
            result.append(randint(int(minimal), int(maximal)))
        return result
