*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify cannot edit customer support contact
    [Tags]    TMCC-3101    ui_ux
    Given the user is on the home screen
    And User is registered in Blue phone
    When Viewing the contact details of the Customer Support contact
    Then The edit button is hidden
