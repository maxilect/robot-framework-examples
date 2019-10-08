*** Settings ***
Documentation       Пример работы с python из Robot Framework.
Library             libraries.ArrayGeneratorLibrary

*** Test Cases ***
Работа с библиотекой, написанной на python.
    ${array}        Генерировать массив чисел    ${5}    ${2}    ${8}
    Log to console    ${array}

Пример обёртки и метода со встроенными аргументами.
    ${array}        Сгенерировать 5 чисел, от 2 до 8
    Log to console    ${array}

Пример передачи части названия метода, в виде параметра. Цикл.
    ${types}        Create list    чётные    нечётные
    ${array}        Сгенерировать 5 чисел, от 12 до 28
    FOR   ${type}   IN    @{types}
        ${numbers}      Run keyword    Найти ${type} числа в списке    ${array}
        log to console     ${numbers}
    END

Пример декоратора метода
    ${negs}         Найти отрицательные числа в ответе, вызвав  Генерировать массив чисел  10  -5  5
    log to console  ${negs}

*** Keywords ***
Найти чётные числа в списке
    [Arguments]     ${list}
    ${evens}        Evaluate    [i for i in $list if i % 2 == 0]
    [Return]        ${evens}

Найти нечётные числа в списке
    [Arguments]     ${list}
    ${odds}         Evaluate    [i for i in $list if i % 2 != 0]
    [Return]        ${odds}

Сгенерировать ${n} чисел, от ${from} до ${to}
    ${result}       Генерировать массив чисел    ${n}    ${from}    ${to}
    [Return]        ${result}

Найти отрицательные числа в ответе, вызвав
    [Arguments]     ${keyword}    @{args}   &{kwargs}
    ${list}         Run keyword    ${keyword}    @{args}    &{kwargs}
    ${negs}         Evaluate    [i for i in $list if i < 0]
    [Return]        ${negs}