*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
navigates to the Settings menu
    Open Settings From Home

the Hidden Menu should not be displayed in the Settings options
    Verify Hidden Menu Is Not In Settings

screen sleep time is set to 1 minute
    Change Sleep Timeout To 1 Minutes

Screen should sleep after 1 minute
    Get Current Screen Brightness Value
    Log To Console    Waiting 70s for screen to sleep after 1 minute idle timeout
    Sleep    70s
    ${state}=    Verify Device Display State    expected_state=OFF    udid=${UDID}
    Should Be Equal As Strings    ${state}    OFF
