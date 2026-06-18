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
