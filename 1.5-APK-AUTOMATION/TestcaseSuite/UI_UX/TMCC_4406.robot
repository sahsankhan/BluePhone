*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - All Settings options are selectable.
    [Tags]    TMCC-4406    ui_ux
    Given the user is on the home screen
    When the user clicks the Settings App
    Then user clicks on Phone option
    And user clicks on Voicemail option
    And user clicks on My Account option
    And user clicks on Network option
    And user clicks on Display option
    And user clicks on Sounds option
    And user clicks on Flasher option
    And user clicks on Date & Time option
    And user clicks on Setup Wizard option
    And user clicks on Reset Phone option
    And user clicks on Software Update option
    And user clicks on Emergency Alerts option
    And user clicks on About option
