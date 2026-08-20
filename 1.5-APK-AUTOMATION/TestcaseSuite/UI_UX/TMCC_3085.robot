*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify edit contact screen buttons UI
    [Tags]    TMCC-3085    ui_ux
    Given AU is on Home screen
    And the AU has a saved contact
    When the AU taps on saved Contacts from the home screen
    And AU taps on Edit icon
    And AU taps on ADD NUMBER button
    Then The edit contact screen displays an Add Number button if there are fewer than 10 saved phone numbers
