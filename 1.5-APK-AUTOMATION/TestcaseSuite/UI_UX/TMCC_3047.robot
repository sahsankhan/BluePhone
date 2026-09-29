*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen phone number type used multiple times
    [Tags]    TMCC-3047    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the user is adding a contact
    Then the user can add multiple phone numbers of the same type ,for example, several 'home' numbers and 'mobile' numbers
