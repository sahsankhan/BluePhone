*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Screen should wake immediately when AU taps on the screen
    [Tags]    TMCC-4461    ui_ux
    Given the user is on the Home screen
    And user put the device in sleep mode
    When the user taps on the screen
    Then the screen should wake up immediately
