*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11449 Test Setup
Test Teardown    TMCC 11449 Test Teardown

*** Test Cases ***

Scenario: VoIP - Verify Hidden Menu is removed from Settings when Phone goes to sleep.
    [Tags]    TMCC-11449
    Given the user is on the home screen
    When user put the device in sleep mode
    When the user taps on the screen
    When navigates to the Settings menu
    Then the Hidden Menu should not be displayed in the Settings options