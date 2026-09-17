*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search with no results
    [Tags]    TMCC-3009    ui_ux
    Given the user is on the Home screen
    And the user is on the Contacts screen
    And there are no contacts matching the search query
    When the user enters a search term in the search field
    Then the screen displays a message "No matches found"
    And no contact results are displayed
