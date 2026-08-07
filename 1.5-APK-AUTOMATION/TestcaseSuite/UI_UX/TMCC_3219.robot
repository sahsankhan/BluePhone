*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify navigation from the Settings-Phone screen to the Home screen.
    [Tags]    TMCC-3219    ui_ux
    Given AU is on Home screen
    And In the Settings - Phone screen
    When Tap on the Home button located in the lower left of the screen
    Then The Home screen refreshes
