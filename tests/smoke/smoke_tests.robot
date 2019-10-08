*** Settings ***
Documentation       Пример smoke-автотеста. С использованием шаблона теста.
...                 Шаблонные тесты легко масштабируются.
...                 Шаблонные тесты так же легко расширяются.
...                 Добавлено тэгирование, в т.ч. размечены не-критичные тесты.
Library             RequestsLibrary
Test Setup          Создать соединение
Test Teardown       Закрыть все соединения
Test Template       Smoke-тест

*** Variables ***
${base_url}         https://en.wikipedia.org/wiki

*** Test Cases ***
Проверить доступность страницы о Ньютоне
    [Tags]              Newton
    /Isaac_Newton       1642

Проверить доступность страницы об Эйнштейне
    [Tags]              Einstein
    /Albert_Einstein    1879

Проверить доступность страницы о Хокинге
    [Tags]              Hawking
    /Stephen_Hawking    1942

Проверить доступность несуществующей страницы (для отображения ошибки)
    [Tags]              Numbers
    /123456789          1899

Проверить доступность несуществующей страницы (для демонстрации не-критичных ошибок)
    [Tags]              Letters    Known
    /abcdefghi          1799

*** Keywords ***
Создать соединение
    Create session     conn     ${base_url}    disable_warnings=1

Закрыть все соединения
    Delete all sessions

Smoke-тест
    [Arguments]     ${url}    ${expected_word}
    ${response}     Get request        conn     ${url}
                    Should be equal    ${response.status_code}    ${200}
    ...                 msg=При выполнении GET ${url} был получен код состояния, отличный от 200 ОК.
                    Проверить наличие слова на странице    ${response.text}    ${expected_word}

Проверить наличие слова на странице
    [Arguments]     ${text}    ${expected_word}
                    Should contain    ${text}    ${expected_word}    msg=Не найдено искомое слово ${expected_word}!
