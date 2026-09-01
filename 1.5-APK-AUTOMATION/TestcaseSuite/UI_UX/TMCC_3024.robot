*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and not confirming favorite
    [Tags]    TMCC-3024    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the AU taps on the gray heart icon
    And the AU selects NO from the favorites confirmation
    Then the phone number is not displayed with a red heart
