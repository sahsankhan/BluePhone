*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and hitting buttons
    [Tags]    TMCC-3016    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the user is on the contact details screen
    When the user taps the back arrow
    Then the user is returned to the contacts list
    When the user taps the home button
    Then the user is taken to the main screen
