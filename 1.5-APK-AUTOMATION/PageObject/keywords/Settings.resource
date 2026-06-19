*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***
Tap on Settings App
    Wait Until Element Is Visible    ${SETTINGS_APP}    ${DEFAULT_TIMEOUT}
    Click Element    ${SETTINGS_APP}
    Log To Console    Tapped on Settings app

Tap on Reset Phone
    Wait Until Element Is Visible    ${RESET_PHONE}    ${DefaultTimeout}
    Click Element    ${RESET_PHONE}
    Log To Console    Tapped on Reset Phone option

Tap on restart phone option
    Wait Until Element Is Visible    ${RESTART_PHONE}    ${DefaultTimeout}
    Click Element    ${RESTART_PHONE}
    Log To Console    Tapped on Restart Phone option

Verify restart confirmation overlay screen appears
    Wait Until Page Contains Element    ${RESTART_ALERT_MSG}    ${DefaultTimeout}
    ${text}=    Get Text    ${RESTART_ALERT_MSG}
    ${normalized}=    Evaluate    ' '.join($text.replace('\\n', ' ').split())
    Should Contain    ${normalized}    Are you sure you want to restart your phone?
    Log    Confirmation overlay screen is displayed with message: ${normalized}    INFO    console=true

Tap on Cancel button on restart confirmation overlay
    Wait Until Element Is Visible    ${CANCEL_RESTART_BTN}    ${DefaultTimeout}
    Click Element    ${CANCEL_RESTART_BTN}
    Log To Console    Tapped on Cancel button on restart confirmation overlay

Verify confirmation overlay is closed
    Page Should Not Contain Element    ${RESTART_ALERT_MSG}
    Log To Console    Confirmation overlay dismissed

Verify Reset Phone screen is still visible
    Element Should Be Visible    ${RESET_PHONE_TITLE}
    Log To Console    Reset Phone screen is still visible

Open Settings From Home
    Navigate To Home Screen
    Wait Until Element Is Visible    ${SETTINGS_APP_TEXT}    ${DefaultTimeout}
    Click Element    ${SETTINGS_APP_TEXT}
    Log To Console    Settings app opened

Change Sleep Timeout To ${minutes} Minutes
    Open Settings From Home
    Wait Until Element Is Visible    ${SETTINGS_DISPLAY}    ${DefaultTimeout}
    Click Element    ${SETTINGS_DISPLAY}
    Wait Until Element Is Visible    ${SETTINGS_SLEEP_TIMEOUT}    ${DefaultTimeout}
    Click Element    ${SETTINGS_SLEEP_TIMEOUT}
    ${locator}=    Get Sleep Timeout Locator    ${minutes}
    Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
    Click Element    ${locator}
    Tap Settings Home Button

Get Sleep Timeout Locator
    [Arguments]    ${minutes}
    ${locator}=    Set Variable If
    ...    '${minutes}' == '1'     ${SETTINGS_SLEEP_1_MIN}
    ...    '${minutes}' == '20'    ${SETTINGS_SLEEP_20_MIN}
    Should Not Be Empty    ${locator}    Invalid sleep timeout '${minutes}'. Allowed: 1, 20
    RETURN    ${locator}

Tap Settings Home Button
    Wait Until Element Is Visible    ${SETTINGS_HOME_BTN}    ${DefaultTimeout}
    Click Element    ${SETTINGS_HOME_BTN}

Get Current Screen Brightness Value
    ${value}=    Get Device Brightness    udid=${UDID}
    Set Global Variable    ${SAVED_BRIGHTNESS}    ${value}

Verify Brightness Restored To Saved Value
    ${current}=    Get Device Brightness    udid=${UDID}
    Should Be Equal As Integers    ${current}    ${SAVED_BRIGHTNESS}

Verify Hidden Menu Is Not In Settings
    Open Settings From Home
    ${found}=    Set Variable    ${False}
    FOR    ${attempt}    IN RANGE    6
        ${found}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${SETTINGS_HIDDEN_MENU}    2
        Exit For Loop If    ${found}
        Scroll Screen Up    max_scrolls=1    delay=1
    END
    Should Be Equal    ${found}    ${False}    msg=Hidden Menu is displayed when it should not be
    Tap Settings Home Button