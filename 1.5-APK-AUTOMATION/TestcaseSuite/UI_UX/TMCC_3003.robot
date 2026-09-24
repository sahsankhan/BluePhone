*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search is case independant
    [Tags]    TMCC-3003    ui_ux
    Given the user is on the Home screen
    And the user is on the Contacts screen
    And the contacts list contains names with uppercase and lowercase letters
    When the user searches uppercase letter A
    Then the results should include all contacts with first and last names starting with "A" or "a"
    When the user searches lowercase letter a
    Then the results should include the same contacts as searching for "A"
