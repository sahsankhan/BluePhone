*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11499 Test Setup
Test Teardown    TMCC 11499 Test Teardown

*** Test Cases ***
Scenario: VoIP - 3-way call (First Call Outbound)
    [Tags]    TMCC-11499    smoke
    Given the user is on the Home screen
    When the user places an outbound call
    And the user makes a secondary outbound call merging the calls
    Then both calls should be merged successfully into a 3-way call
    And the user ends the call
    And post-call screen appears with captions
    And verify call log record with captions
