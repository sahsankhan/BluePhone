*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Variables ***
${CALL_TIME_FIRST}    None
${SECOND_CALL_TIME}    None
${THIRD_CALL_TIME}    None
${SECOND_CALL_DURATION}    None
${THIRD_CALL_DURATION}    None

*** Keywords ***

the call should be recorded as an answered call in the Call Log
    Close Post Call Review Screen
    Tap on Call Log App

no missed call record should be created
    Wait Until Element Is Visible    ${MISSED_CALL_TAB}    ${DefaultTimeout}
    Click Element    ${MISSED_CALL_TAB}
    ${value}=    Verify Recent Call Record Is Present    ${CALL_NUMBER}    ${DID_1}    ${DefaultTimeout}
    Should Not Be True    ${value}    Recent call record is present in missed call tab

user clicks the Call Log App
    Tap on Call Log App

the user clicks the Call Log App
    Run Keyword And Ignore Error    Tap on Close button from post call screen
    user clicks the Call Log App

taps on the Missed tab
    Tap on Missed Call Tab

all the missed calls should be displayed
    Verify Recent Missed Call Record Is Present    ${DID_1}

no duration is displayed
    Verify no duration is displayed for recent missed call record

log icon and time are displayed
    Verify call type is displayed for recent missed call record
    Verify missed call time is displayed for recent missed call record

the missed call details screen displays
    Verify missed call details screen displays

verify call log record with captions
    Tap on Close button from post call screen
    AU navigates to the record in the Call Log
    Compare Captions    duration=30

the user verifies call log record and captions
    Tap on Close button from post call screen
    AU navigates to the record in the Call Log
    Compare Captions    duration=30

There are missed, inbound, and outbound calls
    Verify there are missed, inbound, and outbound calls

user is able to view and search by calls in the call log
    tap on search button in call log
    a search bar should appear at the top of the screen
    Enter Name in Search Field    ${DID_2}
    ${value}=    Get Text    ${CALL_DISPLAY_TEXT}
    ${value}=    Convert To Plain Number    ${value}
    Should Be Equal As Strings    ${value}    ${DID_2}

there are missed calls,inbound calls,outbound calls already present
    Run Keyword And Ignore Error    Click on close button on call log details screen
    ${CALL_TIME_FIRST}=    Get The TimeZone
    Set Global Variable    ${CALL_TIME_FIRST}
    Generate a missed call
    Sleep    5s
    ${SECOND_CALL_TIME}=    Get The TimeZone
    Set Global Variable    ${SECOND_CALL_TIME}
    AU is on the active call screen
    Sleep    5s
    Press Speaker Button    udid=${UDID}
    Wait Until Page Contains Element    ${POST_CALL_DURATION}
    ${SECOND_CALL_DURATION}=    Get Text    ${POST_CALL_DURATION}
    Set Global Variable    ${SECOND_CALL_DURATION}
    Tap on Close button from post call screen
    the user dials the phone number of a second NAU
    ${THIRD_CALL_TIME}=    Get The TimeZone
    Set Global Variable    ${THIRD_CALL_TIME}
    Press Speaker Button    udid=${UDID}
    Sleep    5s
    Press Speaker Button    udid=${UDID}
    Wait Until Page Contains Element    ${POST_CALL_DURATION}
    ${THIRD_CALL_DURATION}=    Get Text    ${POST_CALL_DURATION}
    Set Global Variable    ${THIRD_CALL_DURATION}
    Tap on Close button from post call screen

log icon, time and duration are accurate
    Run Keyword And Ignore Error    Click on close button on call log details screen
    @{list_of_expected_times}=    Create List    ${THIRD_CALL_TIME}    ${SECOND_CALL_TIME}    ${CALL_TIME_FIRST}
    Call Record Should Include The Correct Call Time    ${CALL_LOG_ICON_CLASS}    0    ${list_of_expected_times}
    Call Record Should Include The Correct Call Time    ${CALL_LOG_ICON_CLASS}    1    ${list_of_expected_times}
    Call Record Should Include The Correct Call Time    ${CALL_LOG_ICON_CLASS}    2    ${list_of_expected_times}
    @{EXPECTED_CALL_DURATIONS}=    Create List    ${THIRD_CALL_DURATION}    ${SECOND_CALL_DURATION}
    Call Record Should Include The Correct Call Duration    ${CALL_LOG_ICON_CLASS}    0    ${EXPECTED_CALL_DURATIONS}
    Call Record Should Include The Correct Call Duration    ${CALL_LOG_ICON_CLASS}    1    ${EXPECTED_CALL_DURATIONS}
