*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11193 Test Setup
Test Teardown    TMCC 11193 Test Teardown

*** Test Cases ***

Scenario: VoIP - Verify whether the Restart phone is launching the overlay screen.
    [Tags]    TMCC-11193
    Given the user is on the Home screen
    When the user navigates to Settings 
    And the user taps on Reset Phone
    And selects Restart Phone
    And the confirmation overlay screen appears
    When the user selects Cancel
    Then the confirmation overlay should close and the phone should not restart