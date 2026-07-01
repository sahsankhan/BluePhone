*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
Open Help App
    Navigate To Home Screen
    Wait Until Element Is Visible    ${HELP_APP}    ${DefaultTimeout}
    Click Element    ${HELP_APP}
    Log To Console    Help app opened

Verify Help Option Is Visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
    Element Should Be Visible    ${locator}

Verify Help Videos Screen Is Displayed
    Wait Until Element Is Visible    ${HELP_TOOLBAR_TITLE}    ${DefaultTimeout}
    Element Should Be Visible    ${HELP_TOOLBAR_TITLE}

Verify Help Video Options Are Available
    @{HELP_VIDEO_LOCATORS}=    Create List
    ...    ${HELP_MAKING_CALLS}
    ...    ${HELP_ANSWERING_CALLS}
    ...    ${HELP_CAPTIONING_EXPERIENCE}
    ...    ${HELP_ADDING_CONTACTS_FAVORITES}
    ...    ${HELP_CALLING_CONTACTS_FAVORITES}
    ...    ${HELP_LIGHT_BAR}
    ...    ${HELP_VOICEMAIL}
    ...    ${HELP_CALL_LOG}
    FOR    ${locator}    IN    @{HELP_VIDEO_LOCATORS}
        Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
        Element Should Be Visible    ${locator}
        Log To Console    Verified Help Video option: ${locator}
    END

Verify Help Video Playback For Each Topic
    @{HELP_VIDEO_LOCATORS}=    Create List
    ...    ${HELP_MAKING_CALLS}
    ...    ${HELP_ANSWERING_CALLS}
    ...    ${HELP_CAPTIONING_EXPERIENCE}
    ...    ${HELP_ADDING_CONTACTS_FAVORITES}
    ...    ${HELP_CALLING_CONTACTS_FAVORITES}
    ...    ${HELP_LIGHT_BAR}
    ...    ${HELP_VOICEMAIL}
    ...    ${HELP_CALL_LOG}
    @{HELP_VIDEO_TITLES}=    Create List
    ...    MAKING CALLS
    ...    ANSWERING CALLS
    ...    YOUR CAPTIONING EXPERIENCE
    ...    ADDING CONTACTS & FAVORITES
    ...    CALLING CONTACTS & FAVORITES
    ...    LIGHT BAR
    ...    VOICEMAIL
    ...    CALL LOG
    ${count}=    Get Length    ${HELP_VIDEO_LOCATORS}
    FOR    ${index}    IN RANGE    ${count}
        ${option_locator}=    Get From List    ${HELP_VIDEO_LOCATORS}    ${index}
        ${expected_title}=    Get From List    ${HELP_VIDEO_TITLES}    ${index}
        Wait Until Element Is Visible    ${option_locator}    ${DefaultTimeout}
        Click Element    ${option_locator}
        Sleep    3s
        Wait Until Element Is Visible    ${HELP_TOOLBAR_TITLE}    ${DefaultTimeout}
        ${header}=    Get Text    ${HELP_TOOLBAR_TITLE}
        Should Be Equal As Strings    ${header}    ${expected_title}
        Wait Until Element Is Visible    ${HELP_TOOLBAR_BACK_BTN}    ${DefaultTimeout}
        Click Element    ${HELP_TOOLBAR_BACK_BTN}
        Wait Until Element Is Visible    ${option_locator}    ${DefaultTimeout}
        Log To Console    Verified Help Video playback: ${expected_title}
    END
