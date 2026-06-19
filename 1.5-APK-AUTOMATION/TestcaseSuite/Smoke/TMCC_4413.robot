*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 4413 Test Setup
Test Teardown    TMCC 4413 Test Teardown

*** Test Cases ***

Scenario: VoIP - Missed call log
    [Tags]    TMCC-4413
    Given the user is on the home screen
    And NAU generates a missed call
    And call gets ended
    When user clicks the Call Log App
    And taps on the Missed tab
    Then all the missed calls should be displayed
    And no duration is displayed
    And log icon and time are displayed
    And the missed call details screen displays