*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search results and selecting contact
    [Tags]    TMCC-3012    ui_ux
    Given the user is on the Home screen
    And the user is on the Contacts screen
    And there are contacts saved in the contact list
    When the user enters a matching contact search term
    And the search results display matching contacts
    When the user selects a contact from the search results
    Then the contact detail screen for the selected contact should be displayed
