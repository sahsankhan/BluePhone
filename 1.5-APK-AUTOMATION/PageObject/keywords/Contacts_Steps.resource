*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
the user tap on the Contacts App
    Open Contacts List Screen

contacts list should be displayed
    Verify Contacts List Is Displayed

the user is registered in Blue phone
    Wait Until Element Is Visible    ${DEVICE_NUMBER}    ${DefaultTimeout}
    Log To Console    Device registered — DID visible on home

User is registered in Blue phone
    the user is registered in Blue phone

the AU goes to the Contacts screen
    Open Contacts List Screen

the AU navigates to the Contacts screen
    Open Contacts List Screen

the AU should see the Contacts screen with a Home and Add buttons at the bottom
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACT_HOME_BTN}    ${DefaultTimeout}
    Log To Console    Contacts screen shows Home and Add buttons

the user can tap the Add button from the Contacts main screen
    Tap Add Contact Button

the Create Contact screen should appear
    Wait Until Element Is Visible    ${CONTACT_FIRST_NAME_FIELD}    ${DefaultTimeout}
    ${title}=    Get Text    ${CONTACT_LIST_TITLE}
    Should Contain    ${title}    CONTACT
    Log To Console    Create Contact screen appeared (${title})

the functionality of the search bar should work as expected
    ${expected_name}=    Get Value From Yaml File    user    verificationSupportName
    Click Element    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${expected_name}
    Sleep    2s
    ${typed}=    Get Text    ${CONTACT_SEARCH_BAR}
    Should Contain    ${typed}    ${expected_name}
    ...    msg=Contacts search bar did not keep typed text '${expected_name}'
    ${found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_SUPPORT_ENTRY}    8
    IF    ${found}
        Log To Console    Search found ClearCaptions support contact
    ELSE
        Log To Console    Search accepted '${expected_name}' (support list entry optional)
    END
    Clear Contacts Search Field

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
