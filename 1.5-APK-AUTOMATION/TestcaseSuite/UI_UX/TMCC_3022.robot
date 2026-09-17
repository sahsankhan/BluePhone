*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and avatar heart
    [Tags]    TMCC-3022    ui_ux
    Given the user is on the Home screen
    And the user is viewing a contact's detail page
    When the user selects the option to add the contact to Favorites
    Then the contact's avatar displays with a red heart on the contact detail page
    And the contact's avatar also displays with a red heart in the main contacts list
