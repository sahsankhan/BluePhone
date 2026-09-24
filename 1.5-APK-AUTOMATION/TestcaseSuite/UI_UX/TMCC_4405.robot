*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    UI UX Test Setup
Test Teardown    UI UX Test Teardown

*** Test Cases ***
Scenario: VoIP - Help main screen and help options displayed
    [Tags]    TMCC-4405    ui_ux
    Given the user is on the home screen
    When the user tap the Help App
    Then Overview options should get displayed
    And Using Captions option should get displayed
    And Contacts & Favorites option should get displayed
    And Call Log option should get displayed
    And Voicemail option should get displayed
    And Settings option should get displayed
    And Adjusting Volume option should get displayed
    And Home button displayed on help app
