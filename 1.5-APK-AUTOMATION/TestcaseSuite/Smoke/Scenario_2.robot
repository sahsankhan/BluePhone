*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    Scenario 2 E2E Test Setup
Test Teardown    Scenario 2 E2E Test Teardown

*** Test Cases ***

Scenario: VoIP - End to End Flow (Existing User Login, Outbound Call, Inbound Call, Voicemail Playback, Contacts, Call Log and Voicemail Display)
    [Tags]    TMCC-11546    TMCC-11490    TMCC-11496    TMCC-11461    TMCC-4402    TMCC-4412    TMCC-1743    scenario_2    e2e_full
    [Documentation]    Chained E2E from outbound through contacts/call log/VVM count. Existing-user login (TMCC-11546) commented out for provisioned devices.

    # ===== TMCC-11546: Existing user login + VoIP setup (commented out — provisioned device) =====
    # Given the user is on the home screen
    # Given Existing user can login
    # And the VoIP setup will begin
    # When User Enters street address and zip code
    # Then the user is taken to the main screen
    # ===== End of TMCC-11546 =====

    # ===== TMCC-11490: Outbound call and captions =====
    When the user makes an outbound call
    And the captions should be displayed
    Then the user ends the call
    And post-call screen appears with captions
    And verify call log record with captions
    # ===== End of TMCC-11490 =====

    # ===== TMCC-11496: Inbound call with captions =====
    When the user receives an inbound call and presses the speaker button
    Then the call should connect successfully
    And captions should be displayed during the call
    And the user ends the call
    And the user verifies post-call screen with captions
    And the user taps on close button from post call screen
    And the user verifies call log record and captions
    # ===== End of TMCC-11496 =====

    # ===== TMCC-11461: Voicemail playback =====
    And the AU redirect to home screen
    Then NAU generate the incoming call
    Then click on the ignore button to send call to voicemail
    When the AU taps on the Voicemail icon
    And the AU selects a message from the list
    And taps on the Play button
    # ===== End of TMCC-11461 =====

    # ===== TMCC-4402: Contacts list and display =====
    And the AU redirect to home screen
    When the user tap on the Contacts App
    Then contacts list should be displayed
    # ===== End of TMCC-4402 =====

    # ===== TMCC-4412: Main call log =====
    And the AU redirect to home screen
    And there are missed calls,inbound calls,outbound calls already present
    When the user clicks the Call Log App
    And There are missed, inbound, and outbound calls
    And user is able to view and search by calls in the call log
    And log icon, time and duration are accurate
    # ===== End of TMCC-4412 =====

    # ===== TMCC-1743: VVM message count on list view =====
    And the AU redirect to home screen
    And the user navigates to the Voicemail
    And there is at least one message available to display in the Voicemail section
    Then the quantity of messages will appear in the upper right-hand corner as indicated in the mock-up attached
    # ===== End of TMCC-1743 =====
