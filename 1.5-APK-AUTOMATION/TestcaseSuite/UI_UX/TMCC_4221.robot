*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Select and save ringtone frequency in Settings/ Sounds
    [Tags]    TMCC-4221    ui_ux
    Given the user is on the Home Screen
    And the phone is updated to the sw version that supports this feature
    And the user navigates to the Settings
    And the user taps on the Sounds
    And a Ringtone Frequency stepper box will be displayed
    When the user taps the right facing arrow to change the ringtone option
    Then the options will change from the current value to the next from low to mid to high and back to low again as the user continues to press the right facing arrow
