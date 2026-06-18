*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    Test Setup
Test Teardown    Test Teardown

*** Test Cases ***

Scenario: VoIP - Verify Outbound call from the Contacts screen.
    [Tags]    TMCC-11136
    Given the user is on the Home screen
    And the phone is on-hook
    And there is a saved contact with an associated phone number
    When the AU taps on the phone number
    Then conversation captions are displayed
    And the user ends the call
    And the selected phone number is dialed
