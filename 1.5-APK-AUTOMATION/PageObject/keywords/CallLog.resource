*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***

Verify call log badge is visible on Call Log app icon on home screen
    Wait Until Keyword Succeeds    300s    2s    Wait Until Element Is Visible    ${CALL_LOG_BADGE}    5    Call log badge not displayed.
    Log    Verified call log badge is visible on Call Log app icon on home screen    console=True

Tap on Call Log App
    Navigate To Home Screen
    Wait Until Element Is Visible    ${HOME_CALL_LOG_TILE}    ${DefaultTimeout}
    Click Element    ${HOME_CALL_LOG_TILE}
    Log    User tapped on Call Log app icon    console=True

Verify Recent Missed Call Record Is Present
    [Arguments]    ${expected_number}
    Wait Until Element Is Visible    ${FIRST_MISSED_CALL_NUMBER}    ${DefaultTimeout}
    ${actual_number}=    Get Text    ${FIRST_MISSED_CALL_NUMBER}
    ${plain_number}=    Convert To Plain Number    ${actual_number}
    Should Contain    ${plain_number}    ${expected_number}    Recent call record with number containing '${expected_number}' is not present.
    Log To Console    Verified recent missed call record with number containing '${expected_number}' is present in Missed tab

Tap on Missed Call Tab
    Wait Until Element Is Visible    ${MISSED_CALL_TAB}    ${DefaultTimeout}
    Click Element    ${MISSED_CALL_TAB}
    Log To Console    User tapped on Missed Call tab

Verify no duration is displayed for recent missed call record
    No Duration Is Displayed For Missed Calls    ${CALL_TIME_TEXT}

Verify call type is displayed for recent missed call record
    Wait Until Element Is Visible    ${CALL_TYPE_IMAGE}    ${DefaultTimeout}
    Log To Console    Verified call type icon is displayed for recent missed call record

Verify missed call time is displayed for recent missed call record
    Wait Until Element Is Visible    ${MISSED_CALL_TIME}    ${DefaultTimeout}
    Log To Console    Verified missed call time is displayed for recent missed call record

Verify missed call details screen displays
    Wait Until Element Is Visible    ${MISSED_CALL_ARROW}    ${DefaultTimeout}
    Click Element    ${MISSED_CALL_ARROW}    
    Wait Until Element Is Visible    ${MISSED_CONTACT}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${MISSED_AVTAR}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CALL_BACK_BTN}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${TIME_DATE_OF_MISSED_CALL}    ${DefaultTimeout}
    ${close_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CLOSE_BTN}    5
    Run Keyword If    not ${close_visible}    Wait Until Element Is Visible    ${BACK_BTN_ON_CALL_LOG}    ${DefaultTimeout}
    Log To Console    Verified missed call details screen is displayed with contact name, avatar, callback button, time and date of missed call, and close/back button

Remove all call logs
    Navigate To Home Screen
    Wait Until Element Is Visible    ${HOME_CALL_LOG_TILE}    ${DefaultTimeout}
    Click Element                    ${HOME_CALL_LOG_TILE}
    Sleep    1s

    ${empty_by_id}=      Run Keyword And Return Status    Element Should Be Visible    ${NO_MISSED_CALLS}
    ${empty_by_text}=    Run Keyword And Return Status    Element Should Be Visible    ${NO_CALLS_TEXT}
    ${no_calls_present}=    Evaluate    ${empty_by_id} or ${empty_by_text}

    Run Keyword If    ${no_calls_present}
    ...    Log    No call logs present to delete    console=True
    ...    ELSE
    ...    Run Keywords
    ...    Log    Call logs found — clearing all entries    console=True
    ...    AND    Wait Until Element Is Visible    ${EDIT_BUTTON}    ${DefaultTimeout}
    ...    AND    Click Element             ${EDIT_BUTTON}
    ...    AND    Wait Until Element Is Visible    ${DELETE_ALL_BUTTON}    ${DefaultTimeout}
    ...    AND    Click Element             ${DELETE_ALL_BUTTON}
    ...    AND    Wait Until Element Is Visible    ${YES_BUTTON_TO_DELETE_ALL_CALL_LOGS}    ${DefaultTimeout}
    ...    AND    Click Element             ${YES_BUTTON_TO_DELETE_ALL_CALL_LOGS}
    ...    AND    Call Log Should Be Empty

    Wait Until Element Is Visible    ${CALL_LOG_HOME_BUTTON}    ${DefaultTimeout}
    Click Element                    ${CALL_LOG_HOME_BUTTON}

Call Log Should Be Empty
    ${empty_by_id}=      Run Keyword And Return Status    Wait Until Element Is Visible    ${NO_MISSED_CALLS}    ${DefaultTimeout}
    ${empty_by_text}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${NO_CALLS_TEXT}    ${DefaultTimeout}
    Run Keyword If    not (${empty_by_id} or ${empty_by_text})    Fail    Call logs were not cleared — empty state not shown after delete