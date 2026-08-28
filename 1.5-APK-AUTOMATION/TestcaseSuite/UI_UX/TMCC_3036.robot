*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen scrollbar present
    [Tags]    TMCC-3036    ui_ux
    Given the user is on the Home screen
    And the user is registered in the Blue phone
    When the user is adding a contact
    Then the scrollbar is not visible by default on the new contact screen
