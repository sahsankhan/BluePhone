*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11551 Test Setup
Test Teardown    TMCC 11551 Test Teardown

*** Test Cases ***

Scenario: VoIP - Update help videos - Validation
    [Tags]    TMCC-11551
    Given the Blue device is on the Home screen
    When the user taps on the Help Videos icon
    Then the Help Videos screen is displayed
    And the folllowing Help Video options are available:OVERVIEW,,USING CAPTIONS,CONTACTS & FAVORITES,CALL LOG,VOICEMAIL,SETTINGS,ADJUSTING VOLUME
    And when the user taps on the button of the displayed Help video options; the correct Help video for the topic plays back