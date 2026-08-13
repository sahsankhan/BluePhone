*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Rename the messaging option in Settings
    [Tags]    TMCC-2131    ui_ux
    Given the user is on the Home screen
    When the user taps SETTINGS on the Home screen
    And the main Settings menu is opened
    Then the messaging menu is named Voicemail on the main Settings page and it is displayed directly under the Phone option
