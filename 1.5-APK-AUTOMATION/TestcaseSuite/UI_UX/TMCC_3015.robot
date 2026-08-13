*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and buttons
    [Tags]    TMCC-3015    ui_ux
    Given the user is on the Home screen
    And the AU has a saved contact
    And the user is on the contact details screen
    Then a Home button should be present at the bottom of the screen
    And an Edit button should be present at the bottom of the screen
