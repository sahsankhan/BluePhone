*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify VOIP number displayed at top of list
    [Tags]    TMCC-2991    ui_ux
    Given the user is on the Home screen
    And User is registered in Blue phone
    When the AU navigates to the Contacts screen
    Then at the very top of the contacts list, the text should display "My Number: (xxx) xxx-xxxx" with the correct VOIP number and formatting
