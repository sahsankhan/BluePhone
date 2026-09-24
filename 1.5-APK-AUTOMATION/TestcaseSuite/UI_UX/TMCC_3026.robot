*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and confirming the favorite removal
    [Tags]    TMCC-3026    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the AU taps on the gray heart icon
    And the AU selects YES from the favorites confirmation
    Then the phone number is displayed with a red heart
    When the AU taps on the red heart icon
    Then the user selects YES from the favorites removal confirmation
    And the contact details screen is displayed with a gray heart next to the number
