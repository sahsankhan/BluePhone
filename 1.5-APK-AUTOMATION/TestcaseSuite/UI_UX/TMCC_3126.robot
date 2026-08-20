*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify delete contact confirmation overlay
    [Tags]    TMCC-3126    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the AU is on the Edit Contact screen
    When the AU taps the Delete button
    Then the delete confirmation overlay appears
    And the overlay contains "Yes" and "No" buttons
