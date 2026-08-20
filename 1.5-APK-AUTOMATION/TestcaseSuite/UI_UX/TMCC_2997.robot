*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search header
    [Tags]    TMCC-2997    ui_ux
    Given the user is on the Home screen
    And the AU is on the Contacts screen
    And the Search field is empty
    When the AU taps in the Search field
    Then the header should display a magnifying glass icon
    And the header should display the text "SEARCH"
    And the header should display a CLOSE button
