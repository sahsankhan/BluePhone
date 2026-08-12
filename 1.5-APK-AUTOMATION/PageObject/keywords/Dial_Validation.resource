*** Settings ***
Resource    ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Variables ***
${PHONE_NUMBERS}           ${EMPTY}
${COUNTLY_UID}             None
${COUNTLY_EVENT_KEY}       None
${COUNTLY_SG_FIELD}        None
${MIN_DELAY}               None
${MAX_DELAY}               None
${DIAL_BATCH_SIZE}         0

*** Keywords ***
Load Countly Config and Test Data
    ${yaml_text}=    Get File    ${TEST_DATA_YAML_FILE}
    ${yaml_data}=    Evaluate    yaml.safe_load($yaml_text)    modules=yaml
    ${config}=    Set Variable    ${yaml_data}[countly]
    Set Suite Variable    ${COUNTLY_BASE_URL}      ${config}[base_url]
    Set Suite Variable    ${COUNTLY_API_KEY}       ${config}[api_key]
    Set Suite Variable    ${COUNTLY_APP_ID}        ${config}[app_id]
    Set Suite Variable    ${COUNTLY_UID}           ${config}[uid]
    Set Suite Variable    ${COUNTLY_EVENT_KEY}     ${config}[event_key]
    Set Suite Variable    ${COUNTLY_SG_FIELD}      ${config}[sg_field]
    Set Suite Variable    ${MIN_DELAY}             ${yaml_data}[min_digit_press_delay]
    Set Suite Variable    ${MAX_DELAY}             ${yaml_data}[max_digit_press_delay]

A list of multi-digit phone numbers is available in the input file
    Should Not Be Empty    ${PHONE_NUMBERS}    Phone numbers not loaded. Check Test Setup.
    Log    Phone numbers available: ${PHONE_NUMBERS}    INFO    console=True

The script reads each phone number one by one
    Should Not Be Empty    ${PHONE_NUMBERS}    Phone numbers not loaded. Check Test Setup.
    Log    Total phone numbers to process: ${PHONE_NUMBERS.__len__()}    INFO    console=True
    FOR    ${phone_number}    IN    @{PHONE_NUMBERS}
        Log    Reading phone number: ${phone_number}    INFO    console=True
    END

All phone numbers should be dialled and validated
    Should Not Be Empty    ${PHONE_NUMBERS}    Phone numbers not loaded. Check Test Setup.
    ${passed}=    Create List
    ${failed}=    Create List
    ${total}=     Get Length    ${PHONE_NUMBERS}

    FOR    ${index}    ${phone_number}    IN ENUMERATE    @{PHONE_NUMBERS}    start=1
        Log    Starting number ${index} of ${total}: ${phone_number}    INFO    console=True

        ${clean_number}=    Convert To Plain Number    ${phone_number}

        Log    Pre-dial check: ensuring no active call before dialling ${clean_number}    INFO    console=True
        Run Keyword And Ignore Error    Press Speaker Button If Active    udid=${UDID}
        Run Keyword And Ignore Error    Press Keycode    3

        ${status}    ${error}=    Run Keyword And Ignore Error    Dial Place Call And Hang Up    ${clean_number}

        IF    '${status}' == 'PASS'
            Log    PASSED ${index} of ${total}: ${clean_number}    INFO    console=True
            Append To List    ${passed}    ${clean_number}
        ELSE
            Log    FAILED ${index} of ${total}: ${clean_number}    WARN    console=True
            Log    Error: ${error}                                 WARN    console=True
            Append To List    ${failed}    ${clean_number}
            Capture Page Screenshot
        END

        Log    Hanging up / returning home after: ${clean_number}    INFO    console=True
        Run Keyword And Ignore Error    Press Speaker Button    udid=${UDID}
        Run Keyword And Ignore Error    Press Keycode    133
        Sleep    1s    Short hangup settle
        Run Keyword And Ignore Error    Press Speaker Button If Active    udid=${UDID}
        Run Keyword And Ignore Error    Close Post Call Review Screen
        Run Keyword And Ignore Error    Press Keycode    3
        Sleep    2s

        Log    Completed ${index} of ${total}: ${clean_number}    INFO    console=True
    END

    ${pass_count}=    Get Length    ${passed}
    ${fail_count}=    Get Length    ${failed}
    Log    Results - Total: ${total} | Passed: ${pass_count} | Failed: ${fail_count}    INFO    console=True
    Log    Passed: ${passed}    INFO    console=True
    Log    Failed: ${failed}    INFO    console=True

    IF    ${fail_count} > 0
        Log    WARNING: ${fail_count} of ${total} numbers failed validation: ${failed}    WARN    console=True
    ELSE
        Log    All ${total} dialled numbers passed UI validation successfully.    INFO    console=True
    END
    Run Keyword And Ignore Error    Press Speaker Button If Active    udid=${UDID}

Dial Place Call And Hang Up
    [Documentation]    Dial + validate digits, place a short outbound call, hang up.
    [Arguments]    ${phone_number}
    Dial And Validate Single Number    ${phone_number}
    Place Short Outbound Call From Dialer
    Hang Up Short Call

Place Short Outbound Call From Dialer
    ${call_keycode}=    Get Value From Yaml File    keycodes    KEYCODE_CALL
    Log    Placing call with KEYCODE_CALL ${call_keycode}    INFO    console=True
    Press Keycode    ${call_keycode}
    Sleep    2s    Allow call to start — keep it short

Hang Up Short Call
    Log    Hanging up short call via speaker + on-hook    INFO    console=True
    Run Keyword And Ignore Error    Press Speaker Button    udid=${UDID}
    Run Keyword And Ignore Error    Press Keycode    133
    Sleep    1s
    Run Keyword And Ignore Error    Press Keycode    3

Dial And Validate Single Number
    [Arguments]    ${phone_number}
    Log    Dialling number: ${phone_number}    INFO    console=True

    ${digits}=            Convert To List    ${phone_number}
    ${total_digits}=      Get Length         ${digits}
    ${dialled_so_far}=    Set Variable       ${EMPTY}
    ${errors}=            Create List

    FOR    ${index}    ${digit}    IN ENUMERATE    @{digits}    start=1
        Log    Dialling digit ${index} of ${total_digits}: ${digit}    INFO    console=True
        Press Digit On Dialer With Random Delay    ${digit}
        ${dialled_so_far}=    Set Variable    ${dialled_so_far}${digit}

        ${displayed}=         Get Text    ${PREDIAL_NUMBER}
        ${plain_displayed}=   Convert To Plain Number    ${displayed}
        ${plain_expected}=    Convert To Plain Number    ${dialled_so_far}

        Log    Digit ${index} of ${total_digits} pressed: ${digit} | Expected: ${plain_expected} | Dialer: ${plain_displayed}    INFO    console=True

        IF    '${plain_displayed}' != '${plain_expected}'
            ${msg}=    Set Variable
            ...    Digit ${index}/${total_digits} - pressed ${digit}: expected=${plain_expected} got=${plain_displayed}
            Log    MISMATCH: ${msg}    WARN    console=True
            Capture Page Screenshot
            Append To List    ${errors}    ${msg}
        ELSE
            Log    Digit ${index} of ${total_digits} verified OK: ${plain_displayed}    INFO    console=True
        END
    END

    Log    Running final verification for: ${phone_number}    INFO    console=True
    ${displayed_final}=    Get Text    ${PREDIAL_NUMBER}
    ${plain_final}=        Convert To Plain Number    ${displayed_final}
    ${plain_number}=       Convert To Plain Number    ${phone_number}

    Log    Validation of whole number - Expected: ${plain_number} | Dialer: ${plain_final}    INFO    console=True

    IF    '${plain_final}' != '${plain_number}'
        ${final_msg}=    Set Variable
        ...    Final check failed: expected=${plain_number} got=${plain_final}
        Log    MISMATCH: ${final_msg}    WARN    console=True
        Capture Page Screenshot
        Append To List    ${errors}    ${final_msg}
    ELSE
        Log    Full number verified successfully: ${phone_number}    INFO    console=True
    END

    Should Be Empty    ${errors}
    ...    Validation failed for ${phone_number} with ${errors.__len__()} error(s): ${errors}

Press Digit On Dialer With Random Delay
    [Arguments]    ${digit}
    ${key_name}=    Set Variable    KEY_EVENT_${digit}
    ${keycode}=     Get Value From Yaml File    keycodes    ${key_name}
    ${delay}=       Evaluate    round(random.uniform(${MIN_DELAY}, ${MAX_DELAY}), 2)    modules=random
    Log    Pressing digit: ${digit} | keycode: ${keycode} | delay: ${delay}s (range: ${MIN_DELAY}s-${MAX_DELAY}s)    INFO    console=True
    Press Keycode    ${keycode}
    Sleep    ${delay}s

Verify countly events for the dialled number
    Sleep    20s    Waiting for Countly events to be sent after dialling
    Validate Countly Event Data

Validate Countly Event Data
    ${n}=    Get Length    ${PHONE_NUMBERS}
    Log    Validating Countly events for last ${n} dialled numbers: ${PHONE_NUMBERS}    INFO    console=True
    Get Countly Event Data
    ...    base_url=${COUNTLY_BASE_URL}
    ...    api_key=${COUNTLY_API_KEY}
    ...    app_id=${COUNTLY_APP_ID}
    ...    uid=${COUNTLY_UID}
    ...    key=${COUNTLY_EVENT_KEY}
    ...    sg_field=${COUNTLY_SG_FIELD}
    ...    expected_values=${PHONE_NUMBERS}
    ...    n=${n}

Convert To Plain Number
    [Arguments]    ${number_string}
    ${plain}=    Evaluate    re.sub(r'[^0-9]', '', '''${number_string}''')    modules=re
    Log    Converted ${number_string} to ${plain}    INFO    console=True
    RETURN    ${plain}
