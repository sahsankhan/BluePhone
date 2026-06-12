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