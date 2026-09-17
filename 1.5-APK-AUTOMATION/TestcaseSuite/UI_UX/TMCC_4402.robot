*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Contacts list and display
    [Tags]    TMCC-4402    ui_ux
    Given the user is on the home screen
    When the user tap on the Contacts App
    Then contacts list should be displayed
