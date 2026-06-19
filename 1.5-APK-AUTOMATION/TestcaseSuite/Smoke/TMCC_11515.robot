*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11515 Test Setup
Test Teardown    TMCC 11515 Test Teardown

*** Test Cases ***

Scenario: VoIP - Help main screen and help options displayed
    [Tags]    TMCC-11515
    Given the user is on the home screen
    When the user tap the Help App
    Then Making Calls option should get displayed
    And Answering Calls option should get displayed
    And Your Captioning Experience option should get displayed
    And Adding Contacts and Favorites option should get displayed
    And Calling Contacts and Favorites option should get displayed
    And Light Bar option should get displayed
    And Voicemail option should get displayed
    And Call Log option should get displayed
    And Home button displayed on help app
