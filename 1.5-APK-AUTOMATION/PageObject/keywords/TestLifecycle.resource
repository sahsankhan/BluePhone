*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
# --- Shared atomic teardown helpers (compose only inside per-test hooks below) ---

Capture Failure Artifacts
    Take Screenshot On Failure
    Run Keyword If Test Failed    Capture Page Screenshot    failure.png

Capture Failure Artifacts With SIP Logs
    Capture Failure Artifacts
    Run Keyword And Ignore Error    Derive SIP Logs

Cleanup VoIP Call Session
    Remove Primary Container    type=IB
    Remove Secondary Container    type=IB
    Remove Primary Container    type=OB
    Remove Secondary Container    type=OB

# --- TMCC-11193: Restart Phone overlay (Settings only, no calls) ---

TMCC 11193 Test Setup
    Connecting to BLUphone

TMCC 11193 Test Teardown
    Capture Failure Artifacts

# --- TMCC-11518: Contacts list display ---

TMCC 11518 Test Setup
    Connecting to BLUphone

TMCC 11518 Test Teardown
    Capture Failure Artifacts

# --- TMCC-11517: Favorites list display ---

TMCC 11517 Test Setup
    Connecting to BLUphone

TMCC 11517 Test Teardown
    Capture Failure Artifacts

# --- TMCC-11515: Help main screen options ---

TMCC 11515 Test Setup
    Connecting to BLUphone

TMCC 11515 Test Teardown
    Capture Failure Artifacts

# --- TMCC-11551: Help Videos screen and playback ---

TMCC 11551 Test Setup
    Connecting to BLUphone

TMCC 11551 Test Teardown
    Capture Failure Artifacts

# --- TMCC-3021: Contact favorite (creates Test_01 user2 contact) ---

TMCC 3021 Test Setup
    Connecting to BLUphone

TMCC 3021 Test Teardown
    Capture Failure Artifacts
    Log To Console    Teardown: removing test contact created for TMCC-3021
    Run Keyword And Ignore Error    Delete The Created Contact

# --- TMCC-11462: Empty Favorites text (test clears favorites in scenario) ---

TMCC 11462 Test Setup
    Connecting to BLUphone

TMCC 11462 Test Teardown
    Capture Failure Artifacts

# --- TMCC-11459: Screen wake on tap ---

TMCC 11459 Test Setup
    Connecting to BLUphone

TMCC 11459 Test Teardown
    Capture Failure Artifacts

# --- TMCC-11449: Hidden menu not shown after sleep ---

TMCC 11449 Test Setup
    Connecting to BLUphone

TMCC 11449 Test Teardown
    Capture Failure Artifacts

# --- TMCC-11453 / TMCC-4467: Display sleep timeout and wake ---

TMCC 11453 Test Setup
    Connecting to BLUphone
    Change Sleep Timeout To 20 Minutes

TMCC 11453 Test Teardown
    Capture Failure Artifacts
    Run Keyword And Ignore Error    Change Sleep Timeout To 20 Minutes

TMCC 4467 Test Setup
    Connecting to BLUphone
    Change Sleep Timeout To 20 Minutes

TMCC 4467 Test Teardown
    Capture Failure Artifacts
    Run Keyword And Ignore Error    Change Sleep Timeout To 20 Minutes

# --- TMCC-11239: Inbound answered call — call log validation ---

TMCC 11239 Test Setup
    Connecting to BLUphone
    Remove all call logs

TMCC 11239 Test Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- TMCC-4413: Missed call log ---

TMCC 4413 Test Setup
    Connecting to BLUphone
    Remove all call logs

TMCC 4413 Test Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- TMCC-11134: Voicemail → Call Now outbound ---

TMCC 11134 Test Setup
    Connecting to BLUphone
    Remove all voicemails
    Remove all call logs

TMCC 11134 Test Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- TMCC-11136: Contacts → outbound call (creates Test_01 user2 contact) ---

TMCC 11136 Test Setup
    Connecting to BLUphone
    Remove all call logs

TMCC 11136 Test Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session
    Run Keyword And Ignore Error    Delete The Created Contact
