*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify VOIP indicator present when VOIP is connected
    [Tags]    TMCC-3130    ui_ux
    Given the user is on the Home screen
    And the phone is connected to the ClearCaptions VOIP service
    Then the "CC" icon should appear in the header to indicate VOIP connectivity
