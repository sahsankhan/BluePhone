*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***

the user is on the home screen
    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACTS_APP_TEXT}    ${DefaultTimeout}
    Text Should Be Visible    Contacts
    Log To Console    Contacts app is visible, user is on home screen

the Blue device is on the Home screen
    the user is on the home screen

the user is taken to the main screen
    the user is on the home screen

user put the device in sleep mode
    Wait Until Page Contains Element    ${SLEEP_BAR}    ${DefaultTimeout}
    Click Element    ${SLEEP_BAR}
    Sleep    2s

the user taps on the screen
    Wait Until Page Contains Element    ${BLACK_SCREEN}    ${DefaultTimeout}
    Click Element    ${BLACK_SCREEN}

the Active User (AU) taps on the screen
    the user taps on the screen

the screen should wake up immediately
    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}
    Log To Console    Screen woke up — home screen visible

the screen should wake up immediately And the brightness level should be restored to the previously set value
    the screen should wake up immediately
    Verify Brightness Restored To Saved Value

the brightness level should be restored to the previously set value
    Verify Brightness Restored To Saved Value