*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify, new contact screen header UI.
    [Tags]    TMCC-3030    ui_ux
    Given the user is on the Home screen
    When the AU taps on Contacts from the Home screen
    And the AU taps on the ADD '+' icon to create a new contact
    Then the Add New Contact header displays only the head icon and "New Contact" text
    And no back arrow or cancel button is displayed
