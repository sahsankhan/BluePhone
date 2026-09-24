*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search results filtering
    [Tags]    TMCC-3001    ui_ux
    Given the user is on the Home screen
    And the user is on the Contacts screen
    And there are multiple contacts saved in the contact list
    When the user taps in the Search field
    And starts entering a character
    Then the contact list should be automatically filtered based on the entered character
    And as the user enters additional characters
    Then the search results should continue to be progressively filtered
    And only contacts that match the entered text should remain in the list
