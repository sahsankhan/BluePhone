*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify the maximum allowable handset volume to be entered via the keyboard.
    [Tags]    TMCC-3161    ui_ux
    Given the user is on the Home screen
    When AU enters a number in the Handset Volume field that is greater than the allowable volume of 12, e.g., 15
    Then the number that is greater than 12 is not accepted in the field
    And instead 12 is inserted into the field
