*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search and clearing by close button
    [Tags]    TMCC-3011    ui_ux
    Given the user is on the Home screen
    And the AU is on the Contacts screen
    And the AU has entered text into the Search field
    When the AU taps the Close button in the header
    Then the Search field is cleared
    And the full contacts list is displayed again
