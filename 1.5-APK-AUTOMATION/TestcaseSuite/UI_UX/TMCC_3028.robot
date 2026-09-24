*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen, confirming favorite removal, and viewing Favorites section
    [Tags]    TMCC-3028    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the AU taps on the gray heart icon
    And the AU selects YES from the favorites confirmation
    Then the phone number is displayed with a red heart
    When the AU taps on the red heart icon
    And the AU selects YES from the favorites removal confirmation
    Then if the user selects YES from the favorites removal confirmation and they navigate to the Favorites section
    And the contact is no longer displayed in the favorites list
