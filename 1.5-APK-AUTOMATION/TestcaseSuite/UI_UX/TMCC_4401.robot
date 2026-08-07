*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Home screen and main area icons
    [Tags]    TMCC-4401    ui_ux
    Given the user is on the home screen
    Then the Call Log App should be displayed
    And the Contacts App should be displayed
    And the Favorites App should be displayed
    And the Voicemail App should be displayed
    And the Help App should be displayed
    And the Settings App should be displayed
