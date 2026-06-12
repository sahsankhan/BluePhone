*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    Test Setup
Test Teardown    Test Teardown    

*** Test Cases ***

Scenario: VoIP - Verify, Missed call record should not created in call log for an Inbound call which is already answered by AU.
    [Tags]    TMCC-11239
    Given the user is on the Home screen
    When an inbound call is placed to the Assisted User  
    And the Assisted User answers the call  
    Then the call should be recorded as an answered call in the Call Log  
    And no missed call record should be created
