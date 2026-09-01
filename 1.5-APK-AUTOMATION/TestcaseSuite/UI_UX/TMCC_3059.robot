*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen removing all phone numbers
    [Tags]    TMCC-3059    ui_ux
    Given the user is on the Home screen
    And User is registered in Blue phone
    When the user removes all phone numbers for a contact
    Then the Add Number button remains
