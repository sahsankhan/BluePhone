*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - The updated Ringtone Frequency selection persists after exiting and re-entering Sounds
    [Tags]    TMCC-4224    ui_ux
    Given the user is on the Home Screen
    And the user navigates to the Settings
    And the user taps on the Sounds
    And the user has changed the Ringtone Frequency option to Low or to Med or to High
    And the user exits the Sounds screen in Settings using back arrow or Home button or any button on keypad or due to inbound call notification or when phone goes to sleep
    When the user returns to the Sounds screen in Settings
    Then the last selected ringtone option before exiting the Sounds screen in Settings will be displayed in the Ringtone Frequency stepper box as Low or Med or High
