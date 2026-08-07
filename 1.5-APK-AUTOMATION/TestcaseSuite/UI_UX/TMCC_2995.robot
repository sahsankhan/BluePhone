*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen add button
    [Tags]    TMCC-2995    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the AU navigates to the Contacts screen
    Then the user can tap the Add button from the Contacts main screen
    And the Create Contact screen should appear
