*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify, new contact screen buttons UI.
    [Tags]    TMCC-3034    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the user is adding a contact
    Then the new contact screen displays an "Add Number" button
