*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11239 Test Setup
Test Teardown    TMCC 11239 Test Teardown

*** Test Cases ***

Scenario: VoIP - Verify, Missed call record should not created in call log for an Inbound call which is already answered by AU.
    [Tags]    TMCC-11239
    Given the user is on the Home screen
    When an inbound call is placed to the Assisted User  
    And the Assisted User answers the call  
    Then the call should be recorded as an answered call in the Call Log  
    And no missed call record should be created
