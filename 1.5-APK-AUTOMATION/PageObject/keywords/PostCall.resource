*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***
Close Post Call Review Screen
    ${close_button_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${POST_CALL_SCREEN_CLOSE_BUTTON}    5
    Run Keyword If    ${close_button_visible}    Click Element    ${POST_CALL_SCREEN_CLOSE_BUTTON}
    Run Keyword If    ${close_button_visible}    Log To Console    Closed post call screen