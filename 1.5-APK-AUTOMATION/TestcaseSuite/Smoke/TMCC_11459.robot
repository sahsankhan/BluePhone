*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11459 Test Setup
Test Teardown    TMCC 11459 Test Teardown

*** Test Cases ***

Scenario: VoIP - Screen should wake immediately when AU taps on the screen
    [Tags]    TMCC-11459
    Given the user is on the Home screen
    When user put the device in sleep mode 
    When the user taps on the screen  
    Then the screen should wake up immediately