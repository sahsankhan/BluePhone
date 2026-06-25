*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    TMCC 11462 Test Setup
Test Teardown    TMCC 11462 Test Teardown

*** Test Cases ***

Scenario: VoIP - Add Favorites text should be displayed in the center of the screen
    [Tags]    TMCC-11462
    Given the user is on the home screen
    When add contact to favorite
    And taps on the remove button for all contacts and clicks on the Save button
    Then Add Favorites text should be present in the center of the screen