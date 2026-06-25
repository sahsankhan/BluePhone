*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
Open Favorites App
    Navigate To Home Screen
    Wait Until Element Is Visible    ${FAVORITES_APP}    ${DefaultTimeout}
    Click Element    ${FAVORITES_APP}
    Log To Console    Favorites app opened

Ensure ClearCaptions Favorite Exists
    Open Favorites App
    ${support_name}=    Get Value From Yaml File    user    verificationSupportName
    ${already_in_favorites}=    Run Keyword And Return Status
    ...    Verify Contact Appears In Favorites List    ${support_name}
    Run Keyword If    ${already_in_favorites}    Navigate To Home Screen
    Return From Keyword If    ${already_in_favorites}
    Add ClearCaptions To Favorites From Favorites Add Screen

Add ClearCaptions To Favorites From Favorites Add Screen
    Wait Until Element Is Visible    ${FAVORITES_ADD_BUTTON}    ${DefaultTimeout}
    Click Element    ${FAVORITES_ADD_BUTTON}
    ${contact_name}=    Get Value From Yaml File    user    verificationSupportName
    Wait Until Element Is Visible    ${FAVORITES_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${FAVORITES_SEARCH_BAR}
    Input Text    ${FAVORITES_SEARCH_BAR}    ${contact_name}
    Wait Until Element Is Visible    ${FAVORITES_CONTACT_ROW}    ${DefaultTimeout}
    Click Element    ${FAVORITES_CONTACT_ROW}
    Wait Until Element Is Visible    ${FAVORITES_HEART_BUTTON}    ${DefaultTimeout}
    Click Element    ${FAVORITES_HEART_BUTTON}
    Wait Until Element Is Visible    ${FAVORITES_ADD_CONTACT_BTN}    ${DefaultTimeout}
    Click Element    ${FAVORITES_ADD_CONTACT_BTN}
    Navigate To Home Screen
    Log To Console    ClearCaptions contact added to favorites

Clear All Favorites On Favorites Screen
    Open Favorites App
    ${already_empty}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${FAVORITES_EMPTY_TEXT}    5
    Return From Keyword If    ${already_empty}
    Tap Favorites Edit Button
    Remove All Favorites On Edit Screen
    Tap Favorites Save Button
    Log To Console    All favorites removed from Favorites screen

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
