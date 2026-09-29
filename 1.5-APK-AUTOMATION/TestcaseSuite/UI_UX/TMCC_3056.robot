*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify Add Number hidden at max phone numbers
    [Tags]    TMCC-3056    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    And the AU is on the Contacts screen
    And AU taps on the ADD '+' icon create a contact icon
    When the maximum amount of phone numbers has been reached in a single contact
    Then the "Add Number" button is hidden
