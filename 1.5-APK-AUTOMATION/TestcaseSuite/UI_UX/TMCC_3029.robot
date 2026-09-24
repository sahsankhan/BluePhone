*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and not confirming favorite removal
    [Tags]    TMCC-3029    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the AU taps on the gray heart icon
    And the AU selects YES from the favorites confirmation
    Then the phone number is displayed with a red heart
    When the AU taps on the red heart icon
    And the AU selects NO from the favorites removal confirmation
    Then the contact details screen appears
    And the phone number is still displayed with a red heart
