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
    @{HELP_VIDEOS}=    Create List    OVERVIEW    USING CAPTIONS    CONTACTS & FAVORITES
    ...    CALL LOG    VOICEMAIL    SETTINGS    ADJUSTING VOLUME
    FOR    ${video}    IN    @{HELP_VIDEOS}
        ${locator}=    Set Variable    xpath=//android.widget.Button[@text="${video}"]
        Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
        Element Should Be Visible    ${locator}
        Log To Console    Verified Help Video option: ${video}
    END

Verify Help Video Playback For Each Topic
    @{HELP_VIDEOS}=    Create List    OVERVIEW    USING CAPTIONS    CONTACTS & FAVORITES
    ...    CALL LOG    VOICEMAIL    SETTINGS    ADJUSTING VOLUME
    FOR    ${video}    IN    @{HELP_VIDEOS}
        ${option_locator}=    Set Variable    xpath=//android.widget.Button[@text="${video}"]
        Wait Until Element Is Visible    ${option_locator}    ${DefaultTimeout}
        Click Element    ${option_locator}
        Sleep    3s
        Wait Until Element Is Visible    ${HELP_TOOLBAR_TITLE}    ${DefaultTimeout}
        ${header}=    Get Text    ${HELP_TOOLBAR_TITLE}
        Should Be Equal As Strings    ${header}    ${video}
        Wait Until Element Is Visible    ${HELP_TOOLBAR_BACK_BTN}    ${DefaultTimeout}
        Click Element    ${HELP_TOOLBAR_BACK_BTN}
        Wait Until Element Is Visible    ${option_locator}    ${DefaultTimeout}
    END
