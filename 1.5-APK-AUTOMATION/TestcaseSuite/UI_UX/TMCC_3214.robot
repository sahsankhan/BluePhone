*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify default setting for Amplify Reset.
    [Tags]    TMCC-3214    ui_ux
    Given AU is on Home screen
    And the AU navigates to the Settings screen
    When the AU views the Amplify Reset setting
    Then the default setting should be "OFF"
