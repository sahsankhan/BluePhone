*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen multiple phone numbers on screen display
    [Tags]    TMCC-3060    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the user hits the Add Number button and adds many phone number fields
    Then exactly three phone number fields can appear along with the first and last name fields
