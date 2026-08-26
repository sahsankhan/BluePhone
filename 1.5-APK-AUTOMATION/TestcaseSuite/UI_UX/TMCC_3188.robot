*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify special characters entry rules via the keyboard for Speakerphone Volume.
    [Tags]    TMCC-3188    ui_ux
    Given the user is on the Home screen
    And AU is on Sounds screen
    When using the numeric keyboard, AU enters special characters into the Speakerphone Volume field
    Then special characters are not entered into the Speakerphone Volume field
    And only numbers can be entered
