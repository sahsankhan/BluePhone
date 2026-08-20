*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify edit contact screen header UI
    [Tags]    TMCC-3083    ui_ux
    Given AU is on Home screen
    And the AU has a saved contact
    When the AU taps on saved Contacts from the home screen
    And AU taps on Edit icon
    Then The edit contact header displays the head icon and "Edit Contact" text, plus a Delete button
