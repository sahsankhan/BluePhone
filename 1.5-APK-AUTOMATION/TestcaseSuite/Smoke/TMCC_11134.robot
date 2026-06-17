*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    Test Setup
Test Teardown    Test Teardown    

*** Test Cases ***

Scenario: VoIP - Verify Outbound call from Message Detail or Voicemail Detail screen.
    [Tags]    TMCC-11134
    Given the user is on the Home screen 
    And the phone is on-hook
    And there is a saved Answering Machine message or Voicemail message
    When the AU navigates to the Message Detail or Voicemail Detail screen
    And taps on the contact information or phone number
    Then an overlay screen is displayed with the Call Now button option
    When the AU taps the Call Now button on the overlay screen
    Then captions for the call are displayed
