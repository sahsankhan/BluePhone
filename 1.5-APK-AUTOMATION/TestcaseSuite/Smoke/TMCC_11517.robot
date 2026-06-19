*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11517 Test Setup
Test Teardown    TMCC 11517 Test Teardown

*** Test Cases ***

Scenario: VoIP - Favorites list and display
    [Tags]    TMCC-11517
    Given the user is on the home screen
    When the user clicks the Favorites App
    Then contacts added to favorites should be displayed