*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Verify new contact screen and cancel with data entry and confirm no
    [Tags]    TMCC-3082    ui_ux
    Given AU is on Home screen
    When AU taps on Contacts from home screen
    And AU taps on the ADD '+' icon create a contact icon
    And AU enters at least one character in a field
    And AU taps on CANCEL button
    And AU selects NO option
    Then From the cancel confirmation overlay if the user hits No the create contact screen remains with all information unchanged
