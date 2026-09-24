*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search results and selecting contact then hitting back
    [Tags]    TMCC-3013    ui_ux
    Given the user is on the Home screen
    And the user is on the Contacts screen
    And there are contacts saved in the contact list
    And the user enters a matching contact search term
    And the search results display matching contacts
    When the user selects a name from the search results
    And the contact detail screen is displayed
    And the user taps the Back arrow in the header
    Then the user is returned to the search results
    And the search results remain unchanged
