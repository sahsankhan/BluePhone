*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen and contact minimum requirements
    [Tags]    TMCC-3078    ui_ux
    Given AU is on Home screen
    When AU taps on Contacts from home screen
    And AU taps on the ADD '+' icon create a contact icon
    And AU enters only a first name, or only a last name, or with a phone number and first and last names both
    Then The new contact can be saved with only a first name, or only a last name, or with a phone number and first and last names both
