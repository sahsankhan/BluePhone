*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and removing favorite
    [Tags]    TMCC-3025    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the AU taps on the gray heart icon
    And the AU selects YES from the favorites confirmation
    Then the phone number is displayed with a red heart
    When the AU taps on the red heart icon
    And a confirmation overlay appears stating "Are you sure you want to remove from Favorites?"
