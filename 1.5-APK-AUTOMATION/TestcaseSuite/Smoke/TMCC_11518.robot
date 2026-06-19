*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11518 Test Setup
Test Teardown    TMCC 11518 Test Teardown

*** Test Cases ***

Scenario: VoIP - Contacts list and display
    [Tags]    TMCC-11518
    Given the user is on the home screen
    When the user tap on the Contacts App
    Then contacts list should be displayed