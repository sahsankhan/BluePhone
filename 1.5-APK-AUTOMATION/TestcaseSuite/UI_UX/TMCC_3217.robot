*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify Show Caller ID not displayed in VoIP mode.
    [Tags]    TMCC-3217    ui_ux
    Given AU is on Home screen
    When the user navigates to the Settings
    And the user navigates to Phone
    Then "Show Caller ID" is not displayed on the screen
