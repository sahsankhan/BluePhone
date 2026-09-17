*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Add Favorites text should be displayed in the center of the screen
    [Tags]    TMCC-4458    ui_ux
    Given the user is on the home screen
    And ensure at least one contact is marked as a favorite
    When the user clicks on the Favorites App
    And taps on the Edit button
    And taps on the remove button for all contacts
    And clicks on the Save button
    Then Add Favorites text should be present in the center of the screen
