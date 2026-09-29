*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen max phone numbers
    [Tags]    TMCC-3055    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the user is adding a new contact
    Then the user can add up to 12 numbers in a single contact
