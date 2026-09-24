*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search and names results
    [Tags]    TMCC-3002    ui_ux
    Given the user is on the Home screen
    And the AU is on the Contacts screen
    And the contacts list contains a contact named "John Smith"
    When the AU enters "John" in the Search field
    Then "John Smith" should be displayed in the search results
    When the AU enters "Smith" in the Search field
    Then "John Smith" should be displayed in the search results
