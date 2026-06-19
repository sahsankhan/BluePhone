*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
Open Favorites App
    Navigate To Home Screen
    Wait Until Element Is Visible    ${FAVORITES_APP}    ${DefaultTimeout}
    Click Element    ${FAVORITES_APP}
    Log To Console    Favorites app opened

Ensure ClearCaptions Favorite Exists
    Open Contacts List Screen
    ${has_heart}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${CONTACT_SUPPORT_ENTRY}    5
    IF    not ${has_heart}
        Click Element    ${CONTACT_SUPPORT_ENTRY}
        ${grey_heart}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${CONTACT_HEART_ON_AVATAR}    5
        Run Keyword If    ${grey_heart}    Click Element    ${CONTACT_HEART_ON_AVATAR}
        Run Keyword And Ignore Error    Click Element    ${YES_BTN}
    END
    Navigate To Home Screen

Tap Favorites Edit Button
    Wait Until Element Is Visible    ${FAVORITES_EDIT_BTN}    ${DefaultTimeout}
    Click Element    ${FAVORITES_EDIT_BTN}

Remove All Favorites On Edit Screen
    ${removed}=    Set Variable    ${True}
    WHILE    ${removed}
        ${removed}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${FAVORITES_REMOVE_BTN}    3
        Run Keyword If    ${removed}    Click Element    ${FAVORITES_REMOVE_BTN}
        Run Keyword If    ${removed}    Run Keyword And Ignore Error    Click Element    ${FAVORITES_YES_BTN}
    END

Tap Favorites Save Button
    Wait Until Element Is Visible    ${FAVORITES_SAVE_BTN}    ${DefaultTimeout}
    Click Element    ${FAVORITES_SAVE_BTN}

Verify Add Favorites Empty Text Is Displayed
    Wait Until Element Is Visible    ${FAVORITES_EMPTY_TEXT}    ${DefaultTimeout}
    ${actual_text}=    Get Text    ${FAVORITES_EMPTY_TEXT}
    Should Be Equal    ${actual_text}    Add Favorites

Verify Contact Appears In Favorites List
    [Arguments]    ${contact_name}
    Wait Until Element Is Visible    ${FAVORITES_CONTACT_NAME}    ${DefaultTimeout}
    ${contacts}=    Get WebElements    ${FAVORITES_CONTACT_NAME}
    ${contact_found}=    Set Variable    ${False}
    FOR    ${contact}    IN    @{contacts}
        ${name}=    Set Variable    ${contact.text}
        IF    '${contact_name}' in '${name}'
            ${contact_found}=    Set Variable    ${True}
            BREAK
        END
    END
    Should Be True    ${contact_found}    Contact '${contact_name}' not found in Favorites list
