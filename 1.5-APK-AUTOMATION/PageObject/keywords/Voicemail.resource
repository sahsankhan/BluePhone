*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
there is a saved Answering Machine message or Voicemail message
    Generate inbound call sent to voicemail    duration=120
    Wait Until Keyword Succeeds    300s    5s    Voicemail Badge Should Be Visible
    Log To Console    Voicemail message saved on device

Voicemail Badge Should Be Visible
    Wait Until Element Is Visible    ${VOICEMAIL_BADGE_COUNTER}    10    Voicemail badge not displayed.
    ${badge_count}=    Get Text    ${VOICEMAIL_BADGE_COUNTER}
    Log    Voicemail badge visible with count: ${badge_count}    console=True
    Should Not Be Equal As Integers    ${badge_count}    0    Voicemail badge count is zero.

Generate inbound call sent to voicemail
    [Arguments]    ${duration}=120
    Make Primary Inbound Call    duration=${duration}
    ${ignore_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${IGNORE_BTN}    30
    IF    not ${ignore_visible}
        FOR    ${retry}    IN RANGE    1    4
            Log    Ignore button not visible - Retry attempt ${retry}/3    console=True
            Remove Primary Container    type=OB
            Make Primary Inbound Call    duration=${duration}
            ${ignore_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${IGNORE_BTN}    30
            Exit For Loop If    ${ignore_visible}
            IF    ${retry} == 3 and not ${ignore_visible}
                Fail    Ignore button not visible after 3 retry attempts
            END
        END
    END
    Click Element    ${IGNORE_BTN}
    Sleep    10s    Allow voicemail to be saved after Ignore

the AU navigates to the Message Detail or Voicemail Detail screen
    Open Voicemail App From Home
    Wait until loading spinner gets disappears from the VM list screen

Open Voicemail App From Home
    ${by_text}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VOICEMAIL_APP}    5
    Run Keyword If    ${by_text}    Click Element    ${VOICEMAIL_APP}
    ...    ELSE    Run Keywords
    ...    Wait Until Element Is Visible    ${VOICEMAIL_HOME_TILE}    ${DefaultTimeout}
    ...    AND    Click Element    ${VOICEMAIL_HOME_TILE}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${VOICEMAIL_CONTINUE_BUTTON}    3
    Run Keyword And Ignore Error    Click Element    ${VOICEMAIL_CONTINUE_BUTTON}

Wait until loading spinner gets disappears from the VM list screen
    Log    Waiting for loading spinner to disappear from VM list screen...    console=True
    Wait Until Page Does Not Contain Element    ${VM_LOADING_SPINNER}    320    Loading spinner did not disappear from VM list screen within timeout.
    Log    Loading spinner is no longer visible on VM list screen.    console=True

Wait until voicemail delete completes
    Log    Waiting for voicemail delete loader to finish...    console=True
    Run Keyword And Ignore Error    Wait Until Page Does Not Contain Element    ${VM_DELETE_PROGRESS}    120
    Wait Until Page Does Not Contain Element    ${VM_LOADING_SPINNER}    320    Voicemail delete loader did not finish within timeout.
    Log    Voicemail delete loader finished.    console=True

taps on the contact information or phone number
    Wait Until Element Is Visible    ${FIRST_RECENT_VOICEMAIL}    ${DefaultTimeout}
    Click Element    ${FIRST_RECENT_VOICEMAIL}
    Wait Until Element Is Visible    ${DIAL_ICON}    ${DefaultTimeout}
    Click Element    ${DIAL_ICON}

an overlay screen is displayed with the Call Now button option
    Wait Until Element Is Visible    ${CALL_NOW_BTN}    ${DefaultTimeout}

the AU taps on the Voicemail icon
    Open Voicemail App From Home
    Wait until loading spinner gets disappears from the VM list screen

the AU selects a message from the list
    Wait Until Element Is Visible    ${FIRST_RECENT_VOICEMAIL}    ${DefaultTimeout}
    Click Element    ${FIRST_RECENT_VOICEMAIL}

taps on the Play button
    Wait Until Element Is Visible    ${VM_PLAY_BTN_CENTER}    ${DefaultTimeout}
    Click Element    ${VM_PLAY_BTN_CENTER}
    Log To Console    Tapped voicemail play button

the user navigates to the Voicemail
    Open Voicemail App From Home
    Wait until loading spinner gets disappears from the VM list screen

there is at least one message available to display in the Voicemail section
    ${vm_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FIRST_RECENT_VOICEMAIL}    10
    IF    not ${vm_present}
        Navigate To Home Screen
        Generate a missed call    duration=120
        Wait Until Keyword Succeeds    300s    5s    Voicemail Badge Should Be Visible
        Open Voicemail App From Home
        Wait until loading spinner gets disappears from the VM list screen
        Wait Until Element Is Visible    ${FIRST_RECENT_VOICEMAIL}    ${DefaultTimeout}
    END
    Log To Console    At least one voicemail message is available in the list

the quantity of messages will appear in the upper right-hand corner as indicated in the mock-up attached
    Wait Until Element Is Visible    ${VOICEMAIL_COUNT}    ${DefaultTimeout}
    ${count}=    Get Text    ${VOICEMAIL_COUNT}
    Should Not Be Empty    ${count}    msg=Voicemail quantity badge in upper-right is empty
    Log    VOICEMAIL count visible in header: ${count}    console=True

Verify VOICEMAIL Count
    the quantity of messages will appear in the upper right-hand corner as indicated in the mock-up attached

Remove all voicemails
    [Documentation]    Deletes all voicemails if present, waits for delete to finish, verifies inbox empty, then returns Home.
    Navigate To Home Screen
    ${vm_app_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VOICEMAIL_HOME_TILE}    10
    Run Keyword If    not ${vm_app_visible}    Wait Until Element Is Visible    ${VOICEMAIL_APP}    ${DefaultTimeout}
    Open Voicemail App From Home
    Wait until loading spinner gets disappears from the VM list screen

    ${vm_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FIRST_RECENT_VOICEMAIL}    10
    IF    ${vm_present}
        Log    Voicemails found — clearing all entries    console=True
        Delete all voicemails from list screen
        Wait until voicemail delete completes
        Voicemail Inbox Should Be Empty
    ELSE
        Log    No voicemail rows visible — verifying inbox is empty    console=True
        Voicemail Inbox Should Be Empty
    END
    Navigate To Home Screen

the AU taps the Call Now button on the overlay screen
    Click Element    ${CALL_NOW_BTN}
    Sleep    5s    Allow outbound call to connect
    Press Speaker Button    udid=${UDID}

Delete all voicemails from list screen
    ${edit_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VM_EDIT_BUTTON}    3
    Run Keyword If    ${edit_visible}    Click Element    ${VM_EDIT_BUTTON}
    Wait Until Element Is Visible    ${VM_DELETE_ALL_BUTTON}    ${DefaultTimeout}
    Click Element    ${VM_DELETE_ALL_BUTTON}
    Wait Until Element Is Visible    ${VM_DELETE_YES_ALERT_BTN}    ${DefaultTimeout}
    Click Element    ${VM_DELETE_YES_ALERT_BTN}
    Confirm permanent voicemail delete prompt

Confirm permanent voicemail delete prompt
    Wait Until Keyword Succeeds    20s    1s    Element Should Be Visible    ${VM_PERMANENT_DELETE_MESSAGE}
    ${accept_by_text}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VM_DELETE_ACCEPT_BTN}    10
    Run Keyword If    ${accept_by_text}    Click Element    ${VM_DELETE_ACCEPT_BTN}
    ...    ELSE    Run Keywords
    ...    Wait Until Element Is Visible    ${VM_DELETE_YES_ALERT_BTN}    ${DefaultTimeout}
    ...    AND    Click Element    ${VM_DELETE_YES_ALERT_BTN}
    Log To Console    Tapped ACCEPT on permanent voicemail delete confirmation

Voicemail Inbox Should Be Empty
    Wait Until Keyword Succeeds    120s    3s    Verify Voicemail Inbox Is Empty
    Log To Console    Verified voicemail inbox is empty

Verify Voicemail Inbox Is Empty
    ${empty_id}=       Run Keyword And Return Status    Element Should Be Visible    ${NO_MESSAGES}
    ${empty_text}=     Run Keyword And Return Status    Element Should Be Visible    ${NO_VM_MESSAGES_TEXT}
    ${row_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${FIRST_RECENT_VOICEMAIL}
    IF    ${empty_id}
        ${message}=    Get Text    ${NO_MESSAGES}
        Should Contain    ${message}    You have no messages
    END
    ${inbox_empty}=    Evaluate    ${empty_id} or ${empty_text}
    Should Be True    ${inbox_empty}    Expected empty voicemail inbox message but none was shown.
    Should Not Be True    ${row_visible}    Voicemail message rows are still visible after delete.

the user opens Voicemail app
    Open Voicemail App From Home
    Run Keyword And Ignore Error    Wait until loading spinner gets disappears from the VM list screen

the voicemail screen should open
    ${home}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VM_HOME_BUTTON}    15
    ${empty}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${NO_MESSAGES}    5
    ${row}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FIRST_RECENT_VOICEMAIL}    5
    ${edit}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${VM_EDIT_BUTTON}    5
    ${ready}=    Evaluate    ${home} or ${empty} or ${row} or ${edit}
    Should Be True    ${ready}
    ...    msg=Voicemail main screen did not open
    Log To Console    Voicemail screen opened

the following features should be displayed:a Home button at the bottom of the screen
    Wait Until Element Is Visible    ${VM_HOME_BUTTON}    ${DefaultTimeout}
    Element Should Be Visible    ${VM_HOME_BUTTON}
    Log To Console    Voicemail Home button visible at bottom

