*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify features of Settings > Sounds screen.
    [Tags]    TMCC-3143    ui_ux
    Given the user is on the Home screen
    When the user navigates to the Settings page
    And the user selects the "Sounds" option
    Then the Sounds screen should be displayed
    And the user should see the "Ringer Volume" option with a rotating selector
    And the user should see the "Handset Amplify Volume" option with a rotating selector
    And the user should see the "Speakerphone Amplify Volume" option with a rotating selector
    And the user should see the "Headset/Neckloop Amplify Volume" option with a rotating selector
    And the user should see the "Touchscreen Sounds" toggle
    And the user should see the "Amplify Reset" toggle
    And the user should see the "Home Button" option
