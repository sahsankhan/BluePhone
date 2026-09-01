*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify, new contact screen phone number max characters.
    [Tags]    TMCC-3049    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the user enters a phone number
    Then the user can enter a number up to 25 digits in the phone number field
