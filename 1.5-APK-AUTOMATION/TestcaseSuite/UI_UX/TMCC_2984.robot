*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen avatar UI
    [Tags]    TMCC-2984    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When all contacts display the initials of the contact name within the avatar image
    Then one letter should be displayed if only a first or last name is entered
    And two letters should be displayed if both a first and last name are entered
