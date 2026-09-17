*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen with no favorites
    [Tags]    TMCC-3019    ui_ux
    Given the user is on the Home screen
    And the AU is on the contact details screen
    And the contact has no favorite numbers
    Then the avatar does not display a red badge
    And the phone numbers do not display a red badge
    And the phone number does display gray badge next to it
