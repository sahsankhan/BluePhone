*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen phone number type default option
    [Tags]    TMCC-3046    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the user adds a phone number field
    Then the default phone type option is Mobile for all new phone number fields
