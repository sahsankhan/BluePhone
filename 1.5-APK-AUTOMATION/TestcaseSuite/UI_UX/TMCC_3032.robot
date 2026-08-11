*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen name and number fields UI
    [Tags]    TMCC-3032    ui_ux
    Given the user is on the Home screen
    When the AU taps on Contacts from the Home screen
    And the AU taps on the ADD '+' icon to create a new contact
    Then the New Contact screen displays the First Name and Last Name fields
    And a single Phone Number field is displayed with a red [X] button next to it
