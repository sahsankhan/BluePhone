*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search bar
    [Tags]    TMCC-2990    ui_ux
    Given the user is on the Home screen
    And User is registered in Blue phone
    When the AU navigates to the Contacts screen
    Then a search bar should appear at the top of the screen
    And the functionality of the search bar should work as expected
