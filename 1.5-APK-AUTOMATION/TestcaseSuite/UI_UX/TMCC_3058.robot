*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify, new contact screen removing phone numbers.
    [Tags]    TMCC-3058    ui_ux
    Given the user is on the Home screen
    And User is registered in Blue phone
    When the user hits the x button next to any phone number field
    Then the entire row field and red x button is removed
