*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen and cancel with no entry
    [Tags]    TMCC-3079    ui_ux
    Given the user is on the Home screen
    When the AU taps on Contacts from the Home screen
    And the AU taps on the ADD '+' icon to create a new contact
    And the AU taps on CANCEL button
    Then If the user has not entered at least one character in a field and hits Cancel, the system immediately redirects to the main contacts list screen
