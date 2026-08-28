*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify maximum allowable volume for speakerphone using the keyboard.
    [Tags]    TMCC-3186    ui_ux
    Given the user is on the Home screen
    When using the numeric keyboard, AU enters a number in the Speakerphone Volume field that is greater than the allowable number of 12 e.g. 15
    Then the number that is greater than 12 is not accepted speakerphone volume in the field
    And instead 12 is inserted into speakerphone the field
