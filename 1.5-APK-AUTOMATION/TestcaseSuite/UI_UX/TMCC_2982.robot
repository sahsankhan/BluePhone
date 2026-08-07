*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contacts screen UI
    [Tags]    TMCC-2982    ui_ux
    Given the user is on the Home screen
    And the user is registered in Blue phone
    When the AU goes to the Contacts screen
    Then the AU should see the Contacts screen with a Home and Add buttons at the bottom
