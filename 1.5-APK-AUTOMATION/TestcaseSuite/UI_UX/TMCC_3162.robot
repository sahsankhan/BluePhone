*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify entering 0 value via the keyboard.
    [Tags]    TMCC-3162    ui_ux
    Given the user is on the Home screen
    When AU enters the number "0" in the Handset Volume field
    Then pressing "0" automatically inserts a "7" in the Handset Volume field
