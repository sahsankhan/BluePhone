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

Verify Contacts My Number Formatting
    Wait Until Element Is Visible    ${DEVICE_NUMBER_FROM_CONTACT}    ${DefaultTimeout}
    ${actual_text}=    Get Text    ${DEVICE_NUMBER_FROM_CONTACT}
    Log To Console    Contacts My Number text: ${actual_text}
    Should Match Regexp    ${actual_text}    My Number: \\(\\d{3}\\) \\d{3}-\\d{4}
    ...    msg=Expected 'My Number: (xxx) xxx-xxxx' but got '${actual_text}'

Verify New Contact Header UI
    Wait Until Element Is Visible    ${CONTACT_LIST_TITLE}    ${DefaultTimeout}
    ${title}=    Get Text    ${CONTACT_LIST_TITLE}
    Should Be Equal As Strings    ${title}    NEW CONTACT
    ...    msg=Expected NEW CONTACT header but got '${title}'
    Wait Until Element Is Visible    ${CONTACT_HEADER_ICON}    ${DefaultTimeout}
    Log To Console    New Contact header icon + title verified

Verify No Back Or Cancel On New Contact Header
    ${back}=    Run Keyword And Return Status    Page Should Contain Element    ${CONTACT_TOOLBAR_BACK}
    Should Not Be True    ${back}    msg=Back arrow should NOT be visible on New Contact header
    ${cancel}=    Run Keyword And Return Status    Page Should Contain Element    ${CONTACT_CANCEL_HEADER_BTN}
    Should Not Be True    ${cancel}    msg=Cancel button should NOT be visible on New Contact header

Verify New Contact Name Fields Visible
    Wait Until Element Is Visible    ${CONTACT_FIRST_NAME_FIELD}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACT_LAST_NAME_FIELD}    ${DefaultTimeout}
    Log To Console    First Name and Last Name fields visible

Verify Single Phone Field With Remove Icon
    # Smoke Fill New Contact uses id=et_phone — same locator here
    Wait Until Element Is Visible    ${CONTACT_PHONE_NUMBER_FIELD}    ${DefaultTimeout}
    ${phone_count}=    Get Matching Xpath Count    ${CONTACT_PHONE_FIELD_COUNT}
    Should Be Equal As Integers    ${phone_count}    1
    ...    msg=Expected exactly 1 phone number field, found ${phone_count}
    # 1.5 can expose more than one iv_cancel in the hierarchy; require a visible remove control next to the phone row
    ${cross_count}=    Get Matching Xpath Count    ${CONTACT_REMOVE_NUMBER_COUNT}
    Should Be True    ${cross_count} >= 1
    ...    msg=Expected at least 1 remove (X) icon next to phone field, found ${cross_count}
    Wait Until Element Is Visible    ${CONTACT_REMOVE_NUMBER_ICON}    ${DefaultTimeout}
    Log To Console    Phone field + remove icon verified (phones=${phone_count}, x_icons=${cross_count})

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

the user is adding a contact
    Open Contacts List Screen
    Tap Add Contact Button

the new contact screen displays an "Add Number" button
    ${add_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_BTN}    5
    IF    not ${add_visible}
        Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_ICON}    ${DefaultTimeout}
        Log To Console    Add Number icon (btn_add_field) visible
    ELSE
        Log To Console    ADD NUMBER button visible
    END

the user is on the Contacts screen
    Open Contacts List Screen

the AU taps the back arrow or Home button
    Wait Until Element Is Visible    ${CONTACT_HOME_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_HOME_BTN}
    Log To Console    Tapped Contacts Home button

it returns the user to the main menu
    Wait Until Element Is Visible    ${CONTACT_APP}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_APP}
    Log To Console    Returned to main menu / home

the user adds a phone number field
    Open Contacts List Screen
    Tap Add Contact Button
    ${add_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_BTN}    5
    IF    ${add_visible}
        Click Element    ${CONTACT_ADD_NUMBER_BTN}
    ELSE
        Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_ICON}    ${DefaultTimeout}
        Click Element    ${CONTACT_ADD_NUMBER_ICON}
    END
    Sleep    1s
    Log To Console    Added extra phone number field

the default phone type option is Mobile for all new phone number fields
    Verify Default Phone Type Is Mobile

Verify Default Phone Type Is Mobile
    Wait Until Element Is Visible    ${CONTACT_PHONE_TYPE_SPINNER}    ${DefaultTimeout}
    ${count}=    Get Matching Xpath Count    ${CONTACT_PHONE_TYPE_COUNT}
    Should Be True    ${count} >= 1
    ...    msg=Expected at least 1 phone type spinner, found ${count}
    FOR    ${i}    IN RANGE    1    ${count}+1
        ${text}=    Get Text    xpath=(${CONTACT_PHONE_TYPE_COUNT})[${i}]
        Should Be Equal As Strings    ${text}    Mobile
        ...    msg=Phone type #${i} expected Mobile but got '${text}'
    END
    Log To Console    Default phone type Mobile verified on ${count} field(s)

the AU taps on CANCEL button
    ${cancel_keycode}=    Get Value From Yaml File    keycodes    KEYPAD_CANCEL
    Press Keycode    ${cancel_keycode}
    Sleep    2s
    Log To Console    Pressed CANCEL keycode ${cancel_keycode}

If the user has not entered at least one character in a field and hits Cancel, the system immediately redirects to the main contacts list screen
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    ${still_on_form}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_FIRST_NAME_FIELD}    3
    Should Not Be True    ${still_on_form}
    ...    msg=Cancel with empty form should leave New Contact and return to contacts list
    Log To Console    Cancel with empty form returned to contacts list

the user can choose phone type options: Mobile, Work, Home, and Other
    Verify Phone Type Options

Verify Phone Type Options
    Wait Until Element Is Visible    ${CONTACT_PHONE_TYPE_SPINNER}    ${DefaultTimeout}
    Click Element    ${CONTACT_PHONE_TYPE_SPINNER}
    Wait Until Element Is Visible    ${DROPDOWN_MOBILE}    ${DefaultTimeout}
    Element Should Be Visible    ${DROPDOWN_WORK}
    Element Should Be Visible    ${DROPDOWN_HOME}
    Element Should Be Visible    ${DROPDOWN_OTHER}
    Log To Console    Phone type options Mobile/Work/Home/Other verified
    # Close spinner without changing selection
    Run Keyword And Ignore Error    Press Keycode    4
    Sleep    1s

the cursor is active in the First Name field by default
    verify element is focused    ${CONTACT_FIRST_NAME_FIELD}

verify element is focused
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
    ${focus_status}=    Get Element Attribute    ${locator}    focused
    Log To Console    Element focus status: ${focus_status}
    Should Be Equal As Strings    ${focus_status}    true
    ...    msg=Expected cursor active in First Name field, focused=${focus_status}

the AU has a saved contact
    there is a saved contact with an associated phone number

the user is on the contact details screen
    Open Test Contact Detail From Contacts List
    Wait Until Element Is Visible    ${CONTACT_DETAIL_FULL_NAME}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_SAVED_PHONE_NUMBER}

a Home button should be present at the bottom of the screen
    Wait Until Element Is Visible    ${CONTACT_HOME_BTN}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_HOME_BTN}
    Log To Console    Contact detail Home button visible

an Edit button should be present at the bottom of the screen
    Wait Until Element Is Visible    ${CONTACT_EDIT_BTN}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_EDIT_BTN}
    Log To Console    Contact detail Edit button visible

AU taps on Contacts from home screen open contact screen
    the user is adding a contact

AU taps on Contacts from home screen
    Open Contacts List Screen

AU taps on the ADD '+' icon create a contact icon
    Tap Add Contact Button

Open Add Contact Screen
    the user is adding a contact

AU enters at least one character in a field
    Wait Until Element Is Visible    ${CONTACT_FIRST_NAME_FIELD}    ${DefaultTimeout}
    # Unique name so leftover contacts from other UI_UX cases do not false-match cancel-Yes checks
    ${first}=    Set Variable    ZzCancelOnly
    Set Test Variable    ${CANCEL_TEST_FIRST_NAME}    ${first}
    Input Text    ${CONTACT_FIRST_NAME_FIELD}    ${first}
    Wait Until Element Is Visible    ${CONTACT_PHONE_NUMBER_FIELD}    ${DefaultTimeout}
    ${phone}=    Get Value From Yaml File    user    phoneNumber
    Input Text    ${CONTACT_PHONE_NUMBER_FIELD}    ${phone}
    Log To Console    Entered first name and phone on New Contact

AU taps on CANCEL button
    the AU taps on CANCEL button

The confirmation overlay appears asking Would you like to leave this page without saving your changes along with a Yes and No button
    Wait Until Element Is Visible    ${CONTACT_CANCEL_CONFIRM_MSG}    ${DefaultTimeout}
    ${msg}=    Get Text    ${CONTACT_CANCEL_CONFIRM_MSG}
    Should Contain    ${msg}    leave this page without saving
    ...    msg=Unexpected cancel overlay message: ${msg}
    Wait Until Element Is Visible    ${CONTACT_CANCEL_YES_BTN}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACT_CANCEL_NO_BTN}    ${DefaultTimeout}
    Log To Console    Cancel confirmation overlay with Yes/No verified

AU selects YES option
    Wait Until Element Is Visible    ${CONTACT_CANCEL_YES_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_CANCEL_YES_BTN}
    Log To Console    Selected YES on cancel confirmation

From the cancel confirmation overlay if the user hits Yes the contacts list appears and the new contact is NOT displayed in the contacts list
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    ${first}=    Set Variable    ${CANCEL_TEST_FIRST_NAME}
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Run Keyword And Ignore Error    Clear Text    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${first}
    Sleep    2s
    ${found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_NAME_IN_LIST}    5
    Should Not Be True    ${found}
    ...    msg=Contact '${first}' should NOT appear after cancel Yes
    Log To Console    Verified cancelled contact '${first}' is not in list

focus is placed in the phone number field
    Wait Until Element Is Visible    ${CONTACT_PHONE_NUMBER_FIELD}    ${DefaultTimeout}
    Click Element    ${CONTACT_PHONE_NUMBER_FIELD}
    Log To Console    Focused phone number field

AU selects NO option
    Wait Until Element Is Visible    ${CONTACT_CANCEL_NO_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_CANCEL_NO_BTN}
    Log To Console    Selected NO on cancel confirmation

From the cancel confirmation overlay if the user hits No the create contact screen remains with all information unchanged
    Wait Until Element Is Visible    ${CONTACT_FIRST_NAME_FIELD}    ${DefaultTimeout}
    ${first}=    Get Text    ${CONTACT_FIRST_NAME_FIELD}
    Should Be Equal As Strings    ${first}    ${CANCEL_TEST_FIRST_NAME}
    ...    msg=After Cancel No expected first name '${CANCEL_TEST_FIRST_NAME}' but got '${first}'
    ${phone_ui}=    Get Text    ${CONTACT_PHONE_NUMBER_FIELD}
    ${phone_plain}=    Convert To Plain Number    ${phone_ui}
    ${expected_phone}=    Get Value From Yaml File    user    phoneNumber
    Should Be Equal As Strings    ${phone_plain}    ${expected_phone}
    ...    msg=After Cancel No expected phone '${expected_phone}' but got '${phone_plain}'
    Log To Console    Cancel No kept New Contact data unchanged

the AU is on the Edit Contact screen
    ${on_edit}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_EDIT_HEADER}    3
    IF    ${on_edit}
        Capture Expected Edit Contact Names
        RETURN
    END
    ${on_detail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_EDIT_BTN}    5
    IF    not ${on_detail}
        Open Test Contact Detail From Contacts List
    END
    Wait Until Element Is Visible    ${CONTACT_EDIT_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_EDIT_BTN}
    Wait Until Element Is Visible    ${CONTACT_EDIT_HEADER}    ${DefaultTimeout}
    Capture Expected Edit Contact Names
    Log To Console    On Edit Contact screen

Capture Expected Edit Contact Names
    ${first}=    Get Value From Yaml File    user    createContactFirstName
    ${last}=    Get Value From Yaml File    user    createContactLastName
    Set Test Variable    ${EXPECTED_FIRST}    ${first}
    Set Test Variable    ${EXPECTED_LAST}    ${last}
    ${ui_first}=    Get Text    ${CONTACT_FIRST_NAME_FIELD}
    ${ui_last}=    Get Text    ${CONTACT_LAST_NAME_FIELD}
    Set Test Variable    ${EXPECTED_FIRST}    ${ui_first}
    Set Test Variable    ${EXPECTED_LAST}    ${ui_last}

the AU taps the Delete button
    Wait Until Element Is Visible    ${CONTACT_DELETE_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_DELETE_BTN}
    Log To Console    Tapped Delete on Edit Contact

the delete confirmation overlay appears
    Wait Until Element Is Visible    ${CONTACT_DELETE_CONFIRM_MSG}    ${DefaultTimeout}
    ${msg}=    Get Text    ${CONTACT_DELETE_CONFIRM_MSG}
    Should Contain    ${msg}    delete this contact
    ...    msg=Unexpected delete overlay message: ${msg}
    Log To Console    Delete confirmation overlay visible

the overlay contains "Yes" and "No" buttons
    Wait Until Element Is Visible    ${CONTACT_CANCEL_YES_BTN}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACT_CANCEL_NO_BTN}    ${DefaultTimeout}
    Log To Console    Delete overlay Yes/No verified

the AU selects "No"
    Wait Until Element Is Visible    ${CONTACT_CANCEL_NO_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_CANCEL_NO_BTN}
    Log To Console    Selected NO on delete confirmation

the Edit Contact screen remains open
    Wait Until Element Is Visible    ${CONTACT_EDIT_HEADER}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_EDIT_HEADER}
    Log To Console    Still on Edit Contact

all contact information remains unchanged
    ${current_first}=    Get Text    ${CONTACT_FIRST_NAME_FIELD}
    ${current_last}=    Get Text    ${CONTACT_LAST_NAME_FIELD}
    Should Be Equal As Strings    ${current_first}    ${EXPECTED_FIRST}
    ...    msg=First name changed after Delete No: expected '${EXPECTED_FIRST}' got '${current_first}'
    Should Be Equal As Strings    ${current_last}    ${EXPECTED_LAST}
    ...    msg=Last name changed after Delete No: expected '${EXPECTED_LAST}' got '${current_last}'
    Log To Console    Contact fields unchanged after Delete No

the AU taps on saved Contacts from the home screen
    Open Test Contact Detail From Contacts List

AU taps on Edit icon
    Wait Until Element Is Visible    ${CONTACT_EDIT_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_EDIT_BTN}
    Wait Until Element Is Visible    ${CONTACT_EDIT_HEADER}    ${DefaultTimeout}
    Capture Expected Edit Contact Names
    Log To Console    Tapped Edit icon

The edit contact header displays the head icon and "Edit Contact" text, plus a Delete button
    Wait Until Element Is Visible    ${CONTACT_EDIT_HEADER}    ${DefaultTimeout}
    ${title}=    Get Text    ${CONTACT_LIST_TITLE}
    Should Be Equal As Strings    ${title}    EDIT CONTACT
    ...    msg=Expected EDIT CONTACT header but got '${title}'
    Wait Until Element Is Visible    ${CONTACT_HEADER_ICON}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACT_DELETE_BTN}    ${DefaultTimeout}
    Log To Console    Edit Contact header icon + title + Delete verified

AU taps on ADD NUMBER button
    ${add_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_BTN}    5
    IF    ${add_visible}
        Click Element    ${CONTACT_ADD_NUMBER_BTN}
    ELSE
        Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_ICON}    ${DefaultTimeout}
        Click Element    ${CONTACT_ADD_NUMBER_ICON}
    END
    Sleep    1s
    Log To Console    Tapped ADD NUMBER on Edit Contact

The edit contact screen displays an Add Number button if there are fewer than 10 saved phone numbers
    ${count}=    Get Matching Xpath Count    ${CONTACT_PHONE_FIELD_COUNT}
    Should Be True    ${count} < 10
    ...    msg=Expected fewer than 10 phone fields before asserting Add Number, found ${count}
    ${add_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_BTN}    5
    IF    not ${add_visible}
        Wait Until Element Is Visible    ${CONTACT_ADD_NUMBER_ICON}    ${DefaultTimeout}
    END
    Log To Console    Add Number still available with ${count} phone field(s)

the AU is on the Contacts screen
    Open Contacts List Screen

the Search field is empty
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    ${text}=    Get Text    ${CONTACT_SEARCH_BAR}
    ${empty}=    Run Keyword And Return Status    Should Be Empty    ${text}
    IF    ${empty}
        Log To Console    Contacts Search field empty
        RETURN
    END
    ${lower}=    Convert To Lower Case    ${text}
    Should Contain    ${lower}    looking
    ...    msg=Expected empty/placeholder Search field, got '${text}'
    Log To Console    Contacts Search placeholder OK (${text})

the AU taps in the Search field
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Sleep    1s
    Log To Console    Tapped Contacts Search field

the header should display a magnifying glass icon
    Wait Until Element Is Visible    ${CONTACT_HEADER_ICON}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_HEADER_ICON}
    Log To Console    Search header magnifying glass icon visible

the header should display the text "SEARCH"
    Wait Until Element Is Visible    ${CONTACT_LIST_TITLE}    ${DefaultTimeout}
    ${title}=    Get Text    ${CONTACT_LIST_TITLE}
    Should Be Equal As Strings    ${title}    SEARCH
    ...    msg=Expected SEARCH header but got '${title}'
    Log To Console    Search header title verified

the header should display a CLOSE button
    Wait Until Element Is Visible    ${CONTACT_SEARCH_HEADER_CLOSE}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_SEARCH_HEADER_CLOSE}
    Log To Console    Search header CLOSE verified

the user hits the x button next to any phone number field
    Open Contacts List Screen
    Tap Add Contact Button
    Wait Until Element Is Visible    ${CONTACT_REMOVE_NUMBER_ICON}    ${DefaultTimeout}
    ${before}=    Get Matching Xpath Count    ${CONTACT_PHONE_FIELD_COUNT}
    Set Test Variable    ${PHONE_FIELDS_BEFORE_REMOVE}    ${before}
    Click Element    ${CONTACT_REMOVE_NUMBER_ICON}
    Sleep    1s
    Log To Console    Tapped red X on phone number row

the entire row field and red x button is removed
    ${after}=    Get Matching Xpath Count    ${CONTACT_PHONE_FIELD_COUNT}
    Should Be True    ${after} < ${PHONE_FIELDS_BEFORE_REMOVE}
    ...    msg=Expected phone row removed (before=${PHONE_FIELDS_BEFORE_REMOVE}, after=${after})
    ${phone_gone}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${CONTACT_PHONE_NUMBER_FIELD}    2
    Should Not Be True    ${phone_gone}
    ...    msg=Phone number field still visible after tapping red X
    Log To Console    Phone row and red X removed

the AU is redirected to the Contacts list
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Log To Console    Redirected to Contacts list after delete Yes

the deleted contact is no longer displayed in the Contacts list
    ${first}=    Set Variable    ${EXPECTED_FIRST}
    ${last}=    Set Variable    ${EXPECTED_LAST}
    ${full_name}=    Set Variable    ${first} ${last}
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Run Keyword And Ignore Error    Clear Text    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${full_name}
    Sleep    2s
    ${found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_NAME_IN_LIST}    5
    Should Not Be True    ${found}
    ...    msg=Deleted contact '${full_name}' should NOT appear in Contacts list
    Log To Console    Verified deleted contact '${full_name}' is gone
    Clear Contacts Search Field

the AU starts typing in the Search field
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    Te
    Sleep    1s
    Log To Console    Typed in Contacts Search field

the magnifying glass icon should change to an [x] button
    Wait Until Element Is Visible    ${CONTACT_CLEAR_SEARCH_BTN}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_CLEAR_SEARCH_BTN}
    Log To Console    Search clear [x] button visible after typing

the [x] button is displayed
    Wait Until Element Is Visible    ${CONTACT_CLEAR_SEARCH_BTN}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_CLEAR_SEARCH_BTN}
    Log To Console    Search [x] button displayed

Tap on Close button in the header
    Wait Until Element Is Visible    ${CONTACT_SEARCH_HEADER_CLOSE}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_HEADER_CLOSE}
    Sleep    1s
    Log To Console    Tapped search header CLOSE

the AU clears all text in the Search field
    Wait Until Element Is Visible    ${CONTACT_CLEAR_SEARCH_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_CLEAR_SEARCH_BTN}
    Sleep    1s
    Run Keyword And Ignore Error    Clear Text    ${CONTACT_SEARCH_BAR}
    # Lose focus so search chrome can restore magnifier
    Run Keyword And Ignore Error    Click Element    ${CONTACT_LIST_TITLE}
    Sleep    1s
    Log To Console    Cleared Contacts Search field via [x]

the [x] button should change back to the magnifying glass icon
    ${text}=    Get Text    ${CONTACT_SEARCH_BAR}
    ${empty}=    Run Keyword And Return Status    Should Be Empty    ${text}
    IF    not ${empty}
        ${lower}=    Convert To Lower Case    ${text}
        Should Contain    ${lower}    looking
        ...    msg=Expected empty/placeholder Search after clear, got '${text}'
    END
    Wait Until Element Is Visible    ${CONTACT_HEADER_ICON}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_HEADER_ICON}
    # 1.5 can keep ib_clear in the tree after clear; magnifier + empty/placeholder is the success signal
    Log To Console    Magnifying glass restored after clear (search='${text}')

AU enters only a first name, or only a last name, or with a phone number and first and last names both
    Create Contact By First Name Only    ZzFirstOnly
    Tap Add Contact Button
    Create Contact By Last Name Only    ZzLastOnly
    Tap Add Contact Button
    ${phone}=    Get Value From Yaml File    user    createContactPhoneNumber
    Create Contact By Phone Number Only    ${phone}
    Set Test Variable    ${MIN_REQ_PHONE}    ${phone}
    Log To Console    Created min-requirement contacts (first/last/phone)

The new contact can be saved with only a first name, or only a last name, or with a phone number and first and last names both
    Verify Contact Displayed In Contacts List By Search    ZzFirstOnly
    Clear Contacts Search Field
    Verify Contact Displayed In Contacts List By Search    ZzLastOnly
    Clear Contacts Search Field
    Verify Contact Displayed In Contacts List By Search    ${MIN_REQ_PHONE}
    Clear Contacts Search Field
    Log To Console    Min-requirement contacts verified in list
    Run Keyword And Ignore Error    Delete Contact By Search Name    ZzFirstOnly
    Run Keyword And Ignore Error    Delete Contact By Search Name    ZzLastOnly
    Run Keyword And Ignore Error    Delete Contact By Search Name    ${MIN_REQ_PHONE}

Create Contact By First Name Only
    [Arguments]    ${first_name}
    Wait Until Element Is Visible    ${CONTACT_FIRST_NAME_FIELD}    ${DefaultTimeout}
    Input Text    ${CONTACT_FIRST_NAME_FIELD}    ${first_name}
    SAVE is selected
    Return To Contacts List After Save
    Log To Console    Saved contact with first name only: ${first_name}

Create Contact By Last Name Only
    [Arguments]    ${last_name}
    Wait Until Element Is Visible    ${CONTACT_LAST_NAME_FIELD}    ${DefaultTimeout}
    Input Text    ${CONTACT_LAST_NAME_FIELD}    ${last_name}
    SAVE is selected
    Return To Contacts List After Save
    Log To Console    Saved contact with last name only: ${last_name}

Create Contact By Phone Number Only
    [Arguments]    ${phone_number}
    Wait Until Element Is Visible    ${CONTACT_PHONE_NUMBER_FIELD}    ${DefaultTimeout}
    Input Text    ${CONTACT_PHONE_NUMBER_FIELD}    ${phone_number}
    SAVE is selected
    Return To Contacts List After Save
    Log To Console    Saved contact with phone only: ${phone_number}

Return To Contacts List After Save
    ${on_list}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    8
    IF    ${on_list}
        RETURN
    END
    ${on_detail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_DETAIL_FULL_NAME}    5
    IF    ${on_detail}
        ${back}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_TOOLBAR_BACK}    3
        IF    ${back}
            Click Element    ${CONTACT_TOOLBAR_BACK}
        ELSE
            Run Keyword And Ignore Error    Click Element    ${CONTACT_HOME_BTN}
        END
        Sleep    1s
    END
    ${on_list}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    8
    IF    not ${on_list}
        Open Contacts List Screen
    END
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}

Verify Contact Displayed In Contacts List By Search
    [Arguments]    ${search_text}
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Run Keyword And Ignore Error    Clear Text    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${search_text}
    Sleep    2s
    Wait Until Element Is Visible    ${CONTACT_NAME_IN_LIST}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_NAME_IN_LIST}
    Log To Console    Found contact for search '${search_text}'

Delete Contact By Search Name
    [Arguments]    ${search_text}
    Open Contacts List Screen
    Wait Until Element Is Visible    ${CONTACT_SEARCH_BAR}    ${DefaultTimeout}
    Click Element    ${CONTACT_SEARCH_BAR}
    Run Keyword And Ignore Error    Clear Text    ${CONTACT_SEARCH_BAR}
    Input Text    ${CONTACT_SEARCH_BAR}    ${search_text}
    Sleep    2s
    ${present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_NAME_IN_LIST}    5
    Return From Keyword If    not ${present}
    Click Element    ${CONTACT_NAME_IN_LIST}
    Wait Until Element Is Visible    ${CONTACT_EDIT_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_EDIT_BTN}
    Wait Until Element Is Visible    ${CONTACT_DELETE_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_DELETE_BTN}
    Wait Until Element Is Visible    ${CONTACT_DELETE_YES_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_DELETE_YES_BTN}
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    Clear Contacts Search Field
    Log To Console    Cleaned up contact '${search_text}'

Verify Scrollbar Not Visible On New Contact Screen
    Wait Until Page Does Not Contain Element    ${CONTACT_SCROLL_BAR}    ${DefaultTimeout}
    Log To Console    Scrollbar not visible on New Contact screen

the user taps the back arrow
    Wait Until Element Is Visible    ${CONTACT_TOOLBAR_BACK}    ${DefaultTimeout}
    Click Element    ${CONTACT_TOOLBAR_BACK}
    Log To Console    Tapped back arrow on contact detail

the user is returned to the contacts list
    Wait Until Element Is Visible    ${CONTACT_ADD_BUTTON}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_ADD_BUTTON}
    Log To Console    Returned to contacts list

the user taps the home button
    Wait Until Element Is Visible    ${CONTACT_HOME_BTN}    ${DefaultTimeout}
    Click Element    ${CONTACT_HOME_BTN}
    Log To Console    Tapped Home button from contacts

Create Avatar Test Contact
    [Arguments]    ${first_name}    ${last_name}=${EMPTY}    ${phone_number}=${DID_1}
    Open Contacts List Screen
    Tap Add Contact Button
    Click Element    ${CONTACT_FIRST_NAME_FIELD}
    Input Text    ${CONTACT_FIRST_NAME_FIELD}    ${first_name}
    IF    '${last_name}' != '${EMPTY}'
        Click Element    ${CONTACT_LAST_NAME_FIELD}
        Input Text    ${CONTACT_LAST_NAME_FIELD}    ${last_name}
    END
    Click Element    ${CONTACT_PHONE_NUMBER_FIELD}
    Input Text    ${CONTACT_PHONE_NUMBER_FIELD}    ${phone_number}
    SAVE is selected
    Return To Contacts List After Save
    Log To Console    Created avatar test contact ${first_name} ${last_name}

Verify Contact Avatar Initials
    [Arguments]    ${full_name}
    ${name_parts}=    Split String    ${full_name}
    ${part_count}=    Get Length    ${name_parts}
    IF    ${part_count} == 1
        ${first_name}=    Get From List    ${name_parts}    0
        ${first_initial}=    Get Substring    ${first_name}    0    1
        ${expected_initials}=    Convert To Upper Case    ${first_initial}
    ELSE
        ${first_name}=    Get From List    ${name_parts}    0
        ${last_name}=    Get From List    ${name_parts}    1
        ${first_initial}=    Get Substring    ${first_name}    0    1
        ${last_initial}=    Get Substring    ${last_name}    0    1
        ${expected_initials}=    Convert To Upper Case    ${first_initial}${last_initial}
    END
    Verify Contact Displayed In Contacts List By Search    ${full_name}
    Wait Until Element Is Visible    ${CONTACT_AVATAR_INITIALS}    ${DefaultTimeout}
    ${avatar_text}=    Get Text    ${CONTACT_AVATAR_INITIALS}
    ${actual_initials}=    Strip String    ${avatar_text}
    Should Be Equal As Strings    ${expected_initials}    ${actual_initials}
    ...    msg=Avatar initials mismatch for '${full_name}': expected '${expected_initials}' got '${actual_initials}'
    Log To Console    Avatar initials verified: ${actual_initials} for ${full_name}

Verify Contact Initials Are Present In List
    Wait Until Element Is Visible    ${CONTACT_AVATAR_INITIALS}    ${DefaultTimeout}
    Element Should Be Visible    ${CONTACT_AVATAR_INITIALS}
    Log To Console    Contact avatar initials element visible in list
