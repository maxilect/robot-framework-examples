*** Settings ***
Documentation       Пример smoke-автотеста.
Library             RequestsLibrary

*** Variables ***
${base_url}         https://en.wikipedia.org/wiki
${url}              /

*** Test Cases ***
Проверить доступность Wiki
                    Create session     conn     ${base_url}    disable_warnings=1
    ${response}     Get request        conn     ${url}
                    Delete all sessions
                    Should be equal    ${response.status_code}    ${200}
