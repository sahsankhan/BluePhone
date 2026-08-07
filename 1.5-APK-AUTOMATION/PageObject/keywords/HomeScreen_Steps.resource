*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***

the user is on the home screen
    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACTS_APP_TEXT}    ${DefaultTimeout}
    Text Should Be Visible    Contacts
    Log To Console    Contacts app is visible, user is on home screen

AU is on Home screen
    the user is on the home screen

the Blue device is on the Home screen
    the user is on the home screen

the user is taken to the main screen
    the user is on the home screen

the Call Log App should be displayed
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CALL_LOG_APP}    5
    IF    not ${visible}
        Wait Until Element Is Visible    ${HOME_CALL_LOG_TILE}    ${DefaultTimeout}
    END
    Log To Console    Call Log app displayed on home

the Contacts App should be displayed
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACT_APP}    5
    IF    not ${visible}
        Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}
    END
    Log To Console    Contacts app displayed on home

the Favorites App should be displayed
    Wait Until Element Is Visible    ${FAVORITES_APP}    ${DefaultTimeout}
    Log To Console    Favorites app displayed on home

the Voicemail App should be displayed
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VOICEMAIL_APP}    5
    IF    not ${visible}
        Wait Until Element Is Visible    ${VOICEMAIL_HOME_TILE}    ${DefaultTimeout}
    END
    Log To Console    Voicemail app displayed on home

the Help App should be displayed
    Wait Until Element Is Visible    ${HELP_APP}    ${DefaultTimeout}
    Log To Console    Help app displayed on home

the Settings App should be displayed
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETTINGS_APP}    5
    IF    not ${visible}
        Wait Until Element Is Visible    ${SETTINGS_APP_TEXT}    ${DefaultTimeout}
    END
    Log To Console    Settings app displayed on home

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