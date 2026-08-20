*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify special characters entry rules via the keyboard.
    [Tags]    TMCC-3163    ui_ux
    Given the user is on the Home screen
    And AU is on Sounds screen
    When AU enters special characters into the Handset Volume field
    Then special characters on the numeric keyboard are not entered into the Handset Volume field
    And only numbers can be entered in the field
