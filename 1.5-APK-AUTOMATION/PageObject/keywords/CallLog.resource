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

User selects first record in call log
    Wait Until Element Is Visible    ${ARROW_BUTTON}    ${DefaultTimeout}
    Click Element    ${ARROW_BUTTON}

Tap on Close button from post call screen
    Wait Until Page Contains Element    ${CLOSE_BTN}    ${DefaultTimeout}
    Click Element    ${CLOSE_BTN}

AU navigates to the record in the Call Log
    Tap on Call Log App
    User selects first record in call log

the user taps on close button from post call screen
    Tap on Close button from post call screen

Get The TimeZone
    ${t}=    Get Current Date    result_format=%I:%M %p
    ${t}=    Evaluate    '${t}'.lstrip('0') if '${t}'.startswith('0') else '${t}'
    RETURN    ${t}

Click on close button on call log details screen
    Wait Until Element Is Visible    ${CANCEL_BUTTON}    20
    Click Element    ${CANCEL_BUTTON}

tap on search button in call log
    Wait Until Page Contains Element    ${SEARCH_BUTTON}    ${DefaultTimeout}
    Click Element    ${SEARCH_BUTTON}

a search bar should appear at the top of the screen
    Wait Until Element Is Visible    ${SEARCH_BAR}    ${DefaultTimeout}
    Element Should Be Visible    ${SEARCH_BAR}

Enter Name in Search Field
    [Arguments]    ${contact_name}
    Wait Until Element Is Visible    ${SEARCH_BAR}    ${DefaultTimeout}
    Input Text    ${SEARCH_BAR}    ${contact_name}

Verify there are missed, inbound, and outbound calls
    [Documentation]    Verifies call log has at least one Outgoing, Incoming, and Missed record.
    ${all_records}=    Get WebElements
    ...    xpath=//android.widget.FrameLayout[@resource-id='clrcap.CCClient:id/lvList']//android.widget.ImageView[@resource-id='clrcap.CCClient:id/ivCallType']
    ${total_records}=    Evaluate    len($all_records)
    Should Be True    ${total_records} > 0    msg=No call records found in the call log.
    ${outgoing_count}=    Set Variable    ${0}
    ${incoming_count}=    Set Variable    ${0}
    ${missed_count}=    Set Variable    ${0}
    FOR    ${record}    IN    @{all_records}
        ${call_type}=    Evaluate    $record.get_attribute('contentDescription')
        IF    '${call_type}' == 'OutgoingCall'
            ${outgoing_count}=    Evaluate    $outgoing_count + 1
        ELSE IF    '${call_type}' == 'IncomingCall'
            ${incoming_count}=    Evaluate    $incoming_count + 1
        ELSE IF    '${call_type}' == 'MissedCallUnread' or '${call_type}' == 'MissedCallRead'
            ${missed_count}=    Evaluate    $missed_count + 1
        END
    END
    Log    Call Log Summary | Outgoing: ${outgoing_count} | Incoming: ${incoming_count} | Missed: ${missed_count} | Total: ${total_records}    console=True
    Should Be True    ${outgoing_count} > 0    msg=No Outgoing call records found.
    Should Be True    ${incoming_count} > 0    msg=No Incoming call records found.
    Should Be True    ${missed_count} > 0    msg=No Missed call records found.

Call Record Should Include The Correct Call Time
    [Arguments]    ${locator}    ${index}    ${expected_times}
    ${expected_time}=    Get From List    ${expected_times}    ${index}
    ${position}=    Evaluate    ${index} + 1
    ${text}=    Get Text    xpath=(${locator})[${position}]
    ${time_part}=    Fetch From Left    ${text}    ${SPACE}|${SPACE}
    ${expected_time}=    Evaluate    '${expected_time}'.lstrip('0')
    ${time_part}=    Evaluate    '${time_part}'.lstrip('0')
    ${within_buffer}=    Evaluate
    ...    abs((lambda t: t.hour * 60 + t.minute)(__import__('datetime').datetime.strptime('${time_part}', '%I:%M %p')) - (lambda t: t.hour * 60 + t.minute)(__import__('datetime').datetime.strptime('${expected_time}', '%I:%M %p'))) <= 2
    Should Be True    ${within_buffer}
    ...    msg=Expected '${expected_time}' but found '${time_part}' at index ${index} (outside 2 min buffer)
    Log    Verified call time at index ${index}: ${time_part} (expected: ${expected_time})    console=True

Call Record Should Include The Correct Call Duration
    [Arguments]    ${locator}    ${index}    ${expected_durations}
    ${expected_duration}=    Get From List    ${expected_durations}    ${index}
    ${position}=    Evaluate    ${index} + 1
    ${text}=    Get Text    xpath=(${locator})[${position}]
    ${raw_duration}=    Fetch From Right    ${text}    ${SPACE}|${SPACE}
    ${has_minutes}=    Evaluate    bool(re.search(r'\\d+\\s*min', '${raw_duration}'))    re
    ${minutes}=    Run Keyword If    ${has_minutes}
    ...    Evaluate    re.search(r'(\\d+)\\s*min', '${raw_duration}').group(1)    re
    ...    ELSE    Set Variable    0
    ${seconds}=    Evaluate    re.search(r'(\\d+)\\s*sec', '${raw_duration}').group(1)    re
    ${minutes}=    Evaluate    str(int('${minutes}')).zfill(2)
    ${seconds}=    Evaluate    str(int('${seconds}')).zfill(2)
    ${duration_part}=    Set Variable    ${minutes}:${seconds}
    Should Be Equal    ${duration_part}    ${expected_duration}
    ...    msg=Expected '${expected_duration}' but found '${duration_part}' at index ${index}
    Log    Verified call duration at index ${index}: ${duration_part}    console=True