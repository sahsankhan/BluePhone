*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen and cancel with data entry and confirmation
    [Tags]    TMCC-3080    ui_ux
    Given AU is on Home screen
    When AU taps on Contacts from home screen open contact screen
    And AU enters at least one character in a field
    And AU taps on CANCEL button
    Then The confirmation overlay appears asking Would you like to leave this page without saving your changes along with a Yes and No button
