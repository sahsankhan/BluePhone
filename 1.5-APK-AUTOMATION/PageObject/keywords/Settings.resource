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
    Wait Until Element Is Visible    ${SETTINGS_APP}    ${DefaultTimeout}
    Click Element    ${SETTINGS_APP}
    Log To Console    Settings app opened

Wake Device Screen If Needed
    Run Keyword And Ignore Error    Wake Device Screen    udid=${UDID}
    Sleep    1s

Restore Default Sleep Timeout
    Wake Device Screen If Needed
    Change Sleep Timeout To 5 Minutes
    Log To Console    Sleep timeout restored to default 5 Minutes

Change Sleep Timeout To ${minutes} Minutes
    Wake Device Screen If Needed
    Open Settings From Home
    Wait Until Element Is Visible    ${SETTINGS_DISPLAY}    ${DefaultTimeout}
    Click Element    ${SETTINGS_DISPLAY}
    Adjust Sleep Timeout    ${minutes}
    Tap Settings Home Button

Adjust Sleep Timeout
    [Arguments]    ${minutes}
    ${target}=    Set Variable If    '${minutes}' == '1'    1 Minute    ${minutes} Minutes
    Wait Until Element Is Visible    ${SETTINGS_SLEEP_TIMEOUT}    ${DefaultTimeout}
    FOR    ${i}    IN RANGE    15
        ${current}=    Get Text    ${SETTINGS_SLEEP_TIMEOUT_VALUE}
        Exit For Loop If    '${current}' == '${target}'
        ${current_min}=    Evaluate    int('${current}'.split()[0])
        ${target_min}=    Evaluate    int('${minutes}')
        Run Keyword If    ${target_min} > ${current_min}    Click Element    ${SETTINGS_SLEEP_TIMEOUT_UP}
        Run Keyword If    ${target_min} < ${current_min}    Click Element    ${SETTINGS_SLEEP_TIMEOUT_DOWN}
        Sleep    0.5s
    END
    ${final}=    Get Text    ${SETTINGS_SLEEP_TIMEOUT_VALUE}
    Should Be Equal As Strings    ${final}    ${target}

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
    ${found}=    Run Keyword And Return Status
    ...    Scroll Element Into View    locator=${SETTINGS_HIDDEN_MENU}    max_swipes=5    direction=down
    Should Be Equal    ${found}    ${False}    msg=Hidden Menu is displayed when it should not be
    Tap Settings Home Button