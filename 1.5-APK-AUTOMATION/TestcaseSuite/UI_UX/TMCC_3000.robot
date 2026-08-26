*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen search entry magnifying glass disappears
    [Tags]    TMCC-3000    ui_ux
    Given the user is on the Home screen
    And the AU is on the Contacts screen
    And the Search field is empty
    When the AU starts typing in the Search field
    Then the magnifying glass icon should change to an [x] button
    And Tap on Close button in the header
    And the AU starts typing in the Search field
    And the [x] button is displayed
    When the AU clears all text in the Search field
    Then the [x] button should change back to the magnifying glass icon
