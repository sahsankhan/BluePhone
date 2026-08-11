*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify correct time zone options are present.
    [Tags]    TMCC-2969    ui_ux
    Given the user is on the Home screen
    And the AU is on the Settings, Date & Time screen
    When the AU taps on the time zone rotating selector field
    Then a pop-out selector screen appears
    And the following time zone options are displayed: Hawaii Time, Alaska Time, Pacific Time, Arizona Time, Mountain Time, Central Time, Eastern Time
