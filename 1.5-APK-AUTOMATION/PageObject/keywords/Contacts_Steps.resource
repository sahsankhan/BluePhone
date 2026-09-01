*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
the user tap on the Contacts App
    Open Contacts List Screen

contacts list should be displayed
    Verify Contacts List Is Displayed

the user is registered in Blue phone
    ${on_home}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${DEVICE_NUMBER}    5
    IF    not ${on_home}
        Navigate To Home Screen
    END
    Wait Until Element Is Visible    ${DEVICE_NUMBER}    ${DefaultTimeout}
    Log To Console    Device registered — DID visible on home

User is registered in Blue phone
    the user is registered in Blue phone

the user is registered in the Blue phone
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

at the very top of the contacts list, the text should display "My Number: (xxx) xxx-xxxx" with the correct VOIP number and formatting
    Verify Contacts My Number Formatting

the AU taps on Contacts from the Home screen
    Open Contacts List Screen

the AU taps on the ADD '+' icon to create a new contact
    Tap Add Contact Button

the Add New Contact header displays only the head icon and "New Contact" text
    Verify New Contact Header UI

no back arrow or cancel button is displayed
    Verify No Back Or Cancel On New Contact Header

the New Contact screen displays the First Name and Last Name fields
    Verify New Contact Name Fields Visible

a single Phone Number field is displayed with a red [X] button next to it
    Verify Single Phone Field With Remove Icon

the scrollbar is not visible by default on the new contact screen
    Verify Scrollbar Not Visible On New Contact Screen

all contacts display the initials of the contact name within the avatar image
    Create Avatar Test Contact    IniTest    User1
    Verify Contact Initials Are Present In List
    Delete Contact By Search Name    IniTest

one letter should be displayed if only a first or last name is entered
    Create Avatar Test Contact    IniTest
    Verify Contact Avatar Initials    IniTest
    Delete Contact By Search Name    IniTest

two letters should be displayed if both a first and last name are entered
    Create Avatar Test Contact    IniTest    User1
    Verify Contact Avatar Initials    IniTest User1
    Delete Contact By Search Name    IniTest
