*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen and favorites UI
    [Tags]    TMCC-3018    ui_ux
    Given the user is on the Home screen
    And the user has marked a phone number as a favorite
    When viewing the contact details screen
    Then the avatar displays a red badge
    And the favorited phone number also displays a red badge
