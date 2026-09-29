*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify contact detail screen header
    [Tags]    TMCC-3014    ui_ux
    Given the user is on the Home screen
    When contact app is clicked
    Then the header displays a back arrow,head icon and text "contcats"
