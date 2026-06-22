*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 3021 Test Setup
Test Teardown    TMCC 3021 Test Teardown

*** Test Cases ***

Scenario: VoIP - Verify contact detail screen and confirming favorite
    [Tags]    TMCC-3021
    Given the user is on the Home screen
    And the user selects a grey heart next to a phone number
    And clicks on back button from favorites screen
    Then the contact details screen is displayed
    And a red heart appears next to the phone number