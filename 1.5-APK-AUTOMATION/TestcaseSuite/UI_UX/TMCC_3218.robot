*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify after voicemail option is selected, the voicemail main setup screen features.
    [Tags]    TMCC-3218    ui_ux
    Given AU is on Home screen
    When the user opens Voicemail app
    Then the voicemail screen should open
    And the following features should be displayed:a Home button at the bottom of the screen
