*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen buttons
    [Tags]    TMCC-2983    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    And the user is on the Contacts screen
    When the AU taps the back arrow or Home button
    Then it returns the user to the main menu
