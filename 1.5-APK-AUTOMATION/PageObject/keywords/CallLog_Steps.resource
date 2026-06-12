*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***

no missed call record should be created
    Wait Until Element Is Visible    ${MISSED_CALL_TAB}    ${DefaultTimeout}
    Click Element    ${MISSED_CALL_TAB} 
    ${value}=    Verify Recent Call Record Is Present    ${CALL_NUMBER}    ${DID_1}    ${DefaultTimeout}
    Should Not Be True    ${value}    Recent call record is not present in missed call tab

user clicks the Call Log App
    Tap on Call Log App

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