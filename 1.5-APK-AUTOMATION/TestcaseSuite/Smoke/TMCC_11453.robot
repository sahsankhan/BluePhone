*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11453 Test Setup
Test Teardown    TMCC 11453 Test Teardown

*** Test Cases ***

Scenario: VoIP - Verify screen does not awake with low brightness initially.
    [Tags]    TMCC-11453
    Given the user is on the home screen  
    And screen sleep time is set to 1 minute  
    # When user put the screen to sleep mode
    Then Screen should sleep after 1 minute
    And the Active User (AU) taps on the screen  
    Then the screen should wake up immediately And the brightness level should be restored to the previously set value