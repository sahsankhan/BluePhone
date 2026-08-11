*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify correct features are present on the Settings > Date & Time screen.
    [Tags]    TMCC-2967    ui_ux
    Given the user is on the Home screen
    And the user is on the Settings screen
    When the user navigates to the Date & Time screen
    Then the screen displays a rotating selector field for the time zone
    And the time zone reflects the phone's current location
    And a non-interactive field displays the current time
    And a non-interactive field displays the current date
    And a Home button is visible in the lower left corner of the screen
