*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen and contact saved
    [Tags]    TMCC-3076    ui_ux
    Given AU is on Home screen
    When there is a saved contact with an associated phone number
    Then The contact is saved and the contact details screen appears with the new contact information
