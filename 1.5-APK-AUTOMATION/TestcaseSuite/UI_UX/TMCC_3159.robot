*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify keyboard availability for handset volume settings changes.
    [Tags]    TMCC-3159    ui_ux
    Given the user is on the Home screen
    And AU is on Sounds screen
    When tapping in the Handset Volume field
    Then the Settings - Sounds screen invokes the numeric keyboard
