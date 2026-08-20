*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify delete contact confirmation hitting no
    [Tags]    TMCC-3128    ui_ux
    Given the user is on the Home screen
    And there is a saved contact with an associated phone number
    And the AU is on the Edit Contact screen
    And the AU taps the Delete button
    When the delete confirmation overlay appears
    And the AU selects "No"
    Then the Edit Contact screen remains open
    And all contact information remains unchanged
