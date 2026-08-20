*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify keyboard is available to alter the speakerphone volume using a keyboard.
    [Tags]    TMCC-3184    ui_ux
    Given the user is on the Home screen
    And AU is on Settings screen- Sounds
    When AU taps in the Speakerphone Volume field in the Settings, Sounds screen
    Then the numeric keyboard is invoked.
