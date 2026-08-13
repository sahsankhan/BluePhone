*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen phone number field keyboard display
    [Tags]    TMCC-3048    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    And Open Add Contact Screen
    When focus is placed in the phone number field
    Then Verify that the numeric keyboard is displayed
