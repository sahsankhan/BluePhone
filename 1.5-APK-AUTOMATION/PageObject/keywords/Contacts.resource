*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
there is a saved contact with an associated phone number
    ${contact_first}=    Get Value From Yaml File    user    createContactFirstName
    ${contact_last}=     Get Value From Yaml File    user    createContactLastName
    Add New Contact    ${contact_first}    ${contact_last}    ${DID_1}
    Log To Console    Created contact ${contact_first} ${contact_last} with number ${DID_1}

Add New Contact
    [Arguments]    ${first_name}    ${last_name}    ${phone_number}
    Open Contacts List Screen
    Delete Test Contact If Present
    Tap Add Contact Button
    Fill New Contact Form    ${first_name}    ${last_name}    ${phone_number}
    SAVE is selected
    Wait Until Element Is Visible    ${CONTACT_SAVED_PHONE_NUMBER}    ${DefaultTimeout}

Open Contacts List Screen
    ${on_list}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    5
    Return From Keyword If    ${on_list}
    ${on_home}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_APP}    5
    IF    not ${on_home}
        Navigate To Home Screen
    END
    Wait Until Element Is Visible    ${CONTACT_APP}    ${DefaultTimeout}
    Click Element    ${CONTACT_APP}
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    Log To Console    Contacts list screen opened

Delete Test Contact If Present
    [Documentation]    Removes leftover test contact if it exists. Skips silently if not found, then stays on contacts list.
    ${contact_name}=    Get Value From Yaml File    user    verificationName2
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${contact_name}
    Sleep    2s
    ${contact_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_NAME_IN_LIST}    5
    IF    not ${contact_present}
        Log To Console    No leftover test contact found — ready to create new one
        Clear Contacts Search Field
        Return From Keyword
    END
    Log To Console    Removing leftover test contact before create
    Click Element    ${CONTACT_NAME_IN_LIST}
    Wait Until Element Is Visible    ${CONTACT_EDIT_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_EDIT_BTN}
    Wait Until Element Is Visible    ${CONTACT_DELETE_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_DELETE_BTN}
    Wait Until Element Is Visible    ${CONTACT_DELETE_YES_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_DELETE_YES_BTN}
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    Clear Contacts Search Field
    Log To Console    Deleted existing test contact ${contact_name}

Clear Contacts Search Field
    Run Keyword And Ignore Error    Click Element    ${CONTACT_CLEAR_SEARCH_BTN}
    Run Keyword And Ignore Error    Clear Text    ${CONTACT_SEARCH_BAR}
    Dismiss Contacts Keyboard

Dismiss Contacts Keyboard
    Run Keyword And Ignore Error    Hide Keyboard
    Run Keyword And Ignore Error    Click Element    ${CONTACT_LIST_TITLE}
    Sleep    1s

Tap Add Contact Button
    Dismiss Contacts Keyboard
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    30
    Click Element    ${CONTACT_ADD_BUTTON}
    Wait Until Element Is Visible    ${CONTACT_FIRST_NAME_FIELD}    ${DefaultTimeout}
    Log To Console    Add contact form opened

Fill New Contact Form
    [Arguments]    ${first_name}    ${last_name}    ${phone_number}
    Click Element    ${CONTACT_FIRST_NAME_FIELD}
    Input Text    ${CONTACT_FIRST_NAME_FIELD}    ${first_name}
    Click Element    ${CONTACT_LAST_NAME_FIELD}
    Input Text    ${CONTACT_LAST_NAME_FIELD}    ${last_name}
    Click Element    ${CONTACT_PHONE_NUMBER_FIELD}
    Input Text    ${CONTACT_PHONE_NUMBER_FIELD}    ${phone_number}

SAVE is selected
    ${save_keycode}=    Get Value From Yaml File    button_presscodes    save
    Press Keycode    ${save_keycode}
    Sleep    5s    Allow contact save to complete

the AU taps on the phone number
    Initiate Outbound Call By Tapping Number From Contact Screen

Initiate Outbound Call By Tapping Number From Contact Screen
    Make Primary Outbound Call
    Wait Until Element Is Visible    ${CONTACT_SAVED_PHONE_NUMBER}    ${DefaultTimeout}
    Click Element    ${CONTACT_SAVED_PHONE_NUMBER}
    Sleep    10s    Allow outbound call to connect

Delete The Created Contact
    [Documentation]    Teardown cleanup — deletes test contact if present, then returns Home.
    Run Keyword And Ignore Error    Open Contacts List Screen
    ${on_list}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    5
    Return From Keyword If    not ${on_list}
    Delete Test Contact If Present
    Navigate To Home Screen

Verify Contacts List Is Displayed
    Wait Until Element Is Visible    ${CONTACT_LIST_TITLE}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACT_SUPPORT_ENTRY}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_SUPPORT_ENTRY}
    Log To Console    Contacts list displayed with ClearCaptions entry

Add Contact And Mark Favorite From Favorites Flow
    [Documentation]    TMCC-3021 — create test contact once, add to favorites via grey heart. Does not delete contact.
    ${contact_first}=    Get Value From Yaml File    user    createContactFirstName
    ${contact_last}=     Get Value From Yaml File    user    createContactLastName
    Add New Contact    ${contact_first}    ${contact_last}    ${DID_1}
    Navigate To Home Screen
    Wait Until Element Is Visible    ${FAVORITES_APP}    ${DefaultTimeout}
    Click Element    ${FAVORITES_APP}
    Wait Until Element Is Visible    ${FAVORITES_ADD_BUTTON}    ${DefaultTimeout}
    Click Element    ${FAVORITES_ADD_BUTTON}
    ${contact_name}=    Get Value From Yaml File    user    verificationName2
    Wait Until Element Is Visible    ${FAVORITES_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${FAVORITES_SEARCH_BAR}
    Input Text    ${FAVORITES_SEARCH_BAR}    ${contact_name}
    Wait Until Element Is Visible    ${FAVORITES_CONTACT_ROW}    ${DefaultTimeout}
    Click Element    ${FAVORITES_CONTACT_ROW}
    Wait Until Element Is Visible    ${FAVORITES_HEART_BUTTON}    ${DefaultTimeout}
    Click Element    ${FAVORITES_HEART_BUTTON}
    Wait Until Element Is Visible    ${FAVORITES_ADD_CONTACT_BTN}    ${DefaultTimeout}
    Click Element    ${FAVORITES_ADD_CONTACT_BTN}
    Log To Console    Contact added to favorites from Favorites add screen

Open Test Contact Detail From Contacts List
    [Documentation]    Opens Contacts, searches test contact, taps into detail — no delete.
    Open Contacts List Screen
    ${contact_name}=    Get Value From Yaml File    user    verificationName2
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${contact_name}
    Wait Until Element Is Visible    ${CONTACT_NAME_IN_LIST}    ${DefaultTimeout}
    Click Element    ${CONTACT_NAME_IN_LIST}
    Wait Until Element Is Visible    ${CONTACT_SAVED_PHONE_NUMBER}    ${DefaultTimeout}
    Log To Console    Opened contact detail for ${contact_name}
