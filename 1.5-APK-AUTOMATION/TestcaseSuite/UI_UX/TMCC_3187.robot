*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify entering 0 in the speakerphone volume field using the keyboard.
    [Tags]    TMCC-3187    ui_ux
    Given the user is on the Home screen
    And AU is on Sounds screen
    When using the numeric keyboard, AU enters the number "0" in the Speakerphone Volume field
    Then pressing "0" automatically inserts a "7" in the Speakerphone Volume field
