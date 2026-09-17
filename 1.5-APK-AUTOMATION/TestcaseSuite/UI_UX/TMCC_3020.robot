*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and adding favorite
    [Tags]    TMCC-3020    ui_ux
    Given the user is on the Home screen
    And the user is viewing a phone number with a grey heart icon next to it
    When the user taps the grey heart
    And the overlay states "Are you sure you want to add to Favorites?"
    And the overlay provides options to confirm or cancel the action
