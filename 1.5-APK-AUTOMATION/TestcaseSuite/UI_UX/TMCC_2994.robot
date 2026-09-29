*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen contact name selection
    [Tags]    TMCC-2994    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    And call log record is present in call log
    When the user selects a contact
    Then the contact detail screen should be displayed
