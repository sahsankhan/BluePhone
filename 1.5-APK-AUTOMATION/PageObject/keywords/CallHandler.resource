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

Generate outbound calls by dialling number and without caption comparison
    [Arguments]    ${duration}=None
    FOR    ${attempt}    IN RANGE    1    4
        Log    Outbound call attempt ${attempt} of 3    console=True
        TRY
            Dial Number With Keycodes    ${DID_1}
            Make Primary Outbound Call    ${duration}
            Press Speaker Button    udid=${UDID}
            Verify Call Duration Is Displayed In Header while on Active Call
            RETURN
        EXCEPT    AS    ${error}
            Log    Outbound attempt ${attempt} failed: ${error}    WARN    console=True
            Run Keyword And Ignore Error    Remove Primary Container    type=IB
            Run Keyword If    ${attempt} == 3    Fail    Outbound call failed after 3 attempts: ${error}
        END
    END

the AU is on an active call
    [Arguments]    ${duration}=None
    FOR    ${i}    IN RANGE    3
        Make Primary Inbound Call    ${duration}
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${IGNORE_BTN}    ${DefaultTimeout}
        IF    ${status}
            Press Speaker Button    udid=${UDID}
            Verify Call Duration Is Displayed In Header while on Active Call
            RETURN
        END
        Remove Primary Container    type=OB
    END
    Fail    Inbound call did not reach active call state after 3 attempts

NAU generate the incoming call
    Make Primary Inbound Call    duration=60

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
