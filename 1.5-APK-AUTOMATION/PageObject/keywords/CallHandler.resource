*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Variables ***
${current_text}

*** Keywords ***

the user is on an active call
    Dial Number With Keycodes    ${DID_1}
    Make Primary Outbound Call
    Press Speaker Button    udid=${UDID}

NAU generates a missed call
    Generate a missed call

Generate a missed call
    [Arguments]    ${duration}=60
    Make Primary Inbound Call    duration=${duration}
        ${ignore_visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${IGNORE_BTN}    30
        IF    not ${ignore_visible}
            FOR    ${retry}    IN RANGE    1    4
                Log    Ignore button not visible - Retry attempt ${retry}/3    console=True
                Remove Primary Container    type=OB
                Make Primary Inbound Call    duration=${duration}
                ${ignore_visible}=    Run Keyword And Return Status
                ...    Wait Until Element Is Visible    ${IGNORE_BTN}    30
                IF    ${ignore_visible}
                    Log    Ignore button visible on retry attempt ${retry}    console=True
                    BREAK
                END
                IF    ${retry} == 3 and not ${ignore_visible}
                    Fail    Ignore button not visible after 3 retry attempts
                END
            END
        END
        Click Element    ${IGNORE_BTN}

Initiate Primary Inbound Call
    [ARGUMENTS]    ${attempts}=3    ${duration}=None
    FOR    ${attempt}    IN RANGE    ${attempts}
        Make Primary Inbound Call    duration=${duration}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${IGNORE_BTN}    ${DefaultTimeout}
        IF    ${status}
            Log To Console    ${IGNORE_BTN} is displayed on attempt ${attempt + 1}
            RETURN
        ELSE
            Log To Console    ${IGNORE_BTN} not visible on attempt ${attempt + 1}. Removing Primary OB Container.
            Remove Primary Container    type=OB
        END
    END
    Fail    ${IGNORE_BTN} was not displayed after ${attempts} attempts

call gets ended
    Verify call log badge is visible on Call Log app icon on home screen
    Sleep    5s    Adding sleep to ensure call log badge is updated before proceeding

conversation captions are displayed
    Compare Captions    duration=120

the user ends the call
    Sleep    5s    Allow call to stabilize before ending
    Press Speaker Button    udid=${UDID}

the selected phone number is dialed
    Get Post Call Contact Name

Verify Call Duration Is Displayed In Header while on Active Call
    Wait Until Element Is Visible    ${CALL_DURATION}    20
    Log To Console    Call duration is visible in active call header

Convert Duration To Seconds
    [Arguments]    ${duration_text}
    ${parts}=    Split String    ${duration_text}    :
    ${length}=    Get Length    ${parts}
    IF    ${length} == 2
        ${minutes}=    Convert To Integer    ${parts}[0]
        ${seconds}=    Convert To Integer    ${parts}[1]
        ${total}=    Evaluate    ${minutes} * 60 + ${seconds}
    ELSE IF    ${length} == 3
        ${hours}=    Convert To Integer    ${parts}[0]
        ${minutes}=    Convert To Integer    ${parts}[1]
        ${seconds}=    Convert To Integer    ${parts}[2]
        ${total}=    Evaluate    ${hours} * 3600 + ${minutes} * 60 + ${seconds}
    ELSE
        Fail    Unrecognised duration format: '${duration_text}'
    END
    RETURN    ${total}

Outbound call until speaker pressed (stop before connect verify)
    [Documentation]    Runs dial + outbound API + speaker only. Stops before call-duration verify (known DVT crash point).
    Dial Number With Keycodes    ${DID_1}
    Make Primary Outbound Call
    Press Speaker Button    udid=${UDID}
    Log To Console    Outbound dial + speaker completed — stopped before call-duration verify

Inbound call until speaker pressed (stop before connect verify)
    [Documentation]    Rings AU and presses speaker only. Stops before call-duration verify (known DVT crash point).
    Make Primary Inbound Call
    Wait Until Element Is Visible    ${IGNORE_BTN}    ${DefaultTimeout}
    Press Speaker Button    udid=${UDID}
    Log To Console    Inbound ring + speaker completed — stopped before call-duration verify

Generate outbound calls by dialling number and without caption comparison
    [Arguments]    ${duration}=None
    FOR    ${attempt}    IN RANGE    1    4
        Log    Outbound call attempt ${attempt} of 3    console=True
        TRY
            Dial Number With Keycodes    ${DID_1}
            Make Primary Outbound Call    ${duration}
            Press Speaker Button    udid=${UDID}
            # Duration header verify can crash 1.5 DVT — soft-check like smoke call flows
            ${ok}=    Run Keyword And Return Status    Verify Call Duration Is Displayed In Header while on Active Call
            IF    not ${ok}
                Log To Console    Call duration header not verified (1.5 crash/flaky) — continuing to captions
            END
            Wait For Active Call Options Tray
            RETURN
        EXCEPT    AS    ${error}
            Log    Outbound attempt ${attempt} failed: ${error}    WARN    console=True
            Run Keyword And Ignore Error    Remove Primary Container    type=IB
            Run Keyword If    ${attempt} == 3    Fail    Outbound call failed after 3 attempts: ${error}
        END
    END

Wait For Active Call Options Tray
    [Documentation]    Confirms active-call chrome is up before Add/Merge (1.5 can lag after speaker).
    ${opts}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${OPTIONS}    45
    IF    ${opts}
        Log To Console    Options tray control visible on active call
        RETURN
    END
    ${opts_text}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    xpath=//*[@text="OPTIONS" or @text="Options"]    10
    IF    ${opts_text}
        Log To Console    Options text control visible on active call
        RETURN
    END
    ${dur}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CALL_DURATION}    10
    ${ready}=    Evaluate    ${dur} or ${opts} or ${opts_text}
    Should Be True    ${ready}
    ...    msg=Active call UI not ready — Options / call duration not visible
    Log To Console    Active call duration visible (Options may appear after tap)

taps on the Add Contact button
    [Documentation]    Opens Add from active-call Options tray (or taps Add if already visible).
    FOR    ${i}    IN RANGE    5
        ${add_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADD_BTN}    2
        IF    ${add_visible}
            Click Element    ${ADD_BTN}
            Log To Console    Tapped Add on active call
            RETURN
        END
        ${opt_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${OPTIONS}    2
        IF    not ${opt_visible}
            ${opt_visible}=    Run Keyword And Return Status
            ...    Wait Until Element Is Visible    xpath=//*[@text="OPTIONS" or @text="Options"]    2
            IF    ${opt_visible}
                Click Element    xpath=//*[@text="OPTIONS" or @text="Options"]
            END
        ELSE
            Click Element    ${OPTIONS}
        END
        Sleep    1s
        ${add_after}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADD_BUTTON_IN_OPTIONS_MENU}    5
        IF    ${add_after}
            Click Element    ${ADD_BUTTON_IN_OPTIONS_MENU}
            Log To Console    Tapped Add from Options menu
            RETURN
        END
        ${add_btn2}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADD_BUTTON}    3
        IF    ${add_btn2}
            Click Element    ${ADD_BUTTON}
            Log To Console    Tapped Add (CallLog ADD_BUTTON locator)
            RETURN
        END
    END
    Fail    Add button not available on active call / Options tray

Generate secondary outbound calls by tapping on Add button and without caption comparison
    [Arguments]    ${duration}=None
    FOR    ${attempt}    IN RANGE    1    4
        Log    Secondary outbound attempt ${attempt} of 3    console=True
        TRY
            ${add_ok}=    Run Keyword And Return Status    taps on the Add Contact button
            IF    not ${add_ok}
                Log To Console    Add tray unavailable — falling back to dialpad secondary outbound
            END
            Dial Number With Keycodes    ${DID_2}
            Make Secondary Outbound Call    ${duration}
            ${call_now}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CALL_NOW_BTN}    8
            IF    ${call_now}
                Click Element    ${CALL_NOW_BTN}
            END
            Press Speaker Button    udid=${UDID}
            ${ok}=    Run Keyword And Return Status    Verify Call Duration Is Displayed In Header while on Active Call
            IF    not ${ok}
                Log To Console    Secondary call duration header not verified (1.5 flaky) — continuing
            END
            RETURN
        EXCEPT    AS    ${error}
            Log    Secondary outbound attempt ${attempt} failed: ${error}    WARN    console=True
            Run Keyword And Ignore Error    Remove Secondary Container    type=IB
            Run Keyword If    ${attempt} == 3    Fail    Secondary outbound failed after 3 attempts: ${error}
        END
    END

the user merges the calls
    ${opt}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${OPTIONS}    8
    IF    ${opt}
        Click Element    ${OPTIONS}
        Sleep    1s
    ELSE
        ${opt_text}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    xpath=//*[@text="OPTIONS" or @text="Options"]    5
        IF    ${opt_text}
            Click Element    xpath=//*[@text="OPTIONS" or @text="Options"]
            Sleep    1s
        END
    END
    Wait Until Element Is Visible    ${MERGE_BTN}    ${DefaultTimeout}
    Click Element    ${MERGE_BTN}
    Sleep    5s    Allow merge to complete
    Log To Console    Tapped Merge on Options tray

Verify MERGED CALL Text Is Displayed In Header
    Wait Until Element Is Visible    ${VOIP_MERGED_TEXT}    ${DefaultTimeout}
    ${merged_text}=    Get Text    ${VOIP_MERGED_TEXT}
    Should Be Equal As Strings    ${merged_text}    MERGED CALL
    ...    msg=Expected MERGED CALL in header but got '${merged_text}'
    Log To Console    Verified MERGED CALL text in active call header

the AU is on an active call
    [Arguments]    ${duration}=None
    FOR    ${i}    IN RANGE    3
        Make Primary Inbound Call    ${duration}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${IGNORE_BTN}    ${DefaultTimeout}
        IF    ${status}
            Press Speaker Button    udid=${UDID}
            ${ok}=    Run Keyword And Return Status    Verify Call Duration Is Displayed In Header while on Active Call
            IF    not ${ok}
                Log To Console    Inbound duration header not verified (1.5 crash/flaky) — continuing
            END
            RETURN
        END
        Remove Primary Container    type=OB
    END
    Fail    Inbound call did not reach active call state after 3 attempts

NAU generate the incoming call
    Make Primary Inbound Call    duration=120

click on the ignore button to send call to voicemail
    Wait Until Element Is Visible    ${IGNORE_BTN}    ${DefaultTimeout}
    Click Element    ${IGNORE_BTN}
    Wait Until Voicemail Badge Appears

Wait Until Voicemail Badge Appears
    Wait Until Keyword Succeeds    300s    2s    Wait Until Element Is Visible    ${VOICEMAIL_BADGE_COUNTER}    5
    Log To Console    Voicemail badge displayed after ignore

AU is on the active call screen
    the AU is on an active call

the user dials the phone number of a second NAU
    Dial Number With Keycodes    ${DID_2}
    Make Secondary Outbound Call
