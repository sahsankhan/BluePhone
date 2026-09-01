*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify edit contact screen canceling edits to a contact
    [Tags]    TMCC-3100    ui_ux
    Given AU is on Home screen
    And User is registered in Blue phone
    And there is a saved contact with an associated phone number
    And the AU is on the Edit Contact screen
    When Canceling edits to the contact
    Then The Contact Details page appears with no change
