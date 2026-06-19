*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
the user tap on the Contacts App
    Open Contacts List Screen

contacts list should be displayed
    Verify Contacts List Is Displayed

the contact details screen is displayed
    Wait Until Element Is Visible    ${CONTACT_SAVED_PHONE_NUMBER}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_SAVED_PHONE_NUMBER}

a red heart appears next to the phone number
    ${contact_name}=    Get Value From Yaml File    user    verificationName2
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${contact_name}
    Wait Until Element Is Visible    ${CONTACT_HEART_ON_AVATAR}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_HEART_ON_AVATAR}

the user selects a grey heart next to a phone number
    Add Contact And Mark Favorite From Favorites Flow

clicks on back button from favorites screen
    Wait Until Element Is Visible    ${FAVORITES_BACK_BTN}    ${DefaultTimeout}
    Click Element    ${FAVORITES_BACK_BTN}
