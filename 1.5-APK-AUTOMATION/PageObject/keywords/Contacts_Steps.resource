*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
the user tap on the Contacts App
    Open Contacts List Screen

contacts list should be displayed
    Verify Contacts List Is Displayed

the contact details screen is displayed
    Open Test Contact Detail From Contacts List
    Wait Until Element Is Visible    ${CONTACT_DETAIL_FULL_NAME}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_SAVED_PHONE_NUMBER}

a red heart appears next to the phone number
    Wait Until Element Is Visible    ${CONTACT_HEART_ON_AVATAR}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_HEART_ON_AVATAR}
    Log To Console    Red heart verified on contact detail screen

the user selects a grey heart next to a phone number
    Add Contact And Mark Favorite From Favorites Flow

clicks on back button from favorites screen
    Wait Until Element Is Visible    ${FAVORITES_BACK_BTN}    ${DefaultTimeout}
    Click Element    ${FAVORITES_BACK_BTN}
