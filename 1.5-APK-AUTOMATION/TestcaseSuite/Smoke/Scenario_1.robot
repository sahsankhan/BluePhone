*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    Scenario 1 E2E Test Setup
Test Teardown    Scenario 1 E2E Test Teardown

*** Test Cases ***

Scenario: VoIP - End to End Flow (New User Login, Outbound Call, Inbound Call and Voicemail Playback)
    [Tags]    TMCC-11547    TMCC-11490    TMCC-11496    TMCC-11461    scenario_1    e2e_full
    [Documentation]    Chained E2E from outbound through voicemail. Onboarding (TMCC-11547) commented out for provisioned devices.

    # TMCC-11547: New user login and VoIP onboarding (commented out — requires fresh/unprovisioned device)
    # Given new user can login
    # And Consent forms load for new user
    # And User clicks on Next button
    # And Self-certification loads
    # And User clicks on Next button of self-certification
    # And TOS/Privacy Policy loads
    # And User clicks on Submit button of TOS/Privacy Policy
    # And Enters year and SSN
    # And Verify Registration Page
    # And Verify TOS and privacy policy acknowledgment screen
    # And Accept terms of use
    # And Verify CPNI agreement acknowledgment screen
    # And CPNI loads
    # When the user opts in or out
    # Then the VoIP setup will begin
    # And User Enters street address and zip code

    # TMCC-11490: Outbound call with captions
    When the user makes an outbound call
    And the captions should be displayed
    Then the user ends the call
    And post-call screen appears with captions
    And verify call log record with captions

    # TMCC-11496: Inbound call with captions
    When the user receives an inbound call and presses the speaker button
    Then the call should connect successfully
    And captions should be displayed during the call
    And the user ends the call
    And the user verifies post-call screen with captions
    And the user taps on close button from post call screen
    And the user verifies call log record and captions

    # TMCC-11461: Voicemail playback
    And the AU redirect to home screen
    Then NAU generate the incoming call
    Then click on the ignore button to send call to voicemail
    When the AU taps on the Voicemail icon
    And the AU selects a message from the list
    And taps on the Play button
