*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
# --- Shared atomic teardown helpers (compose only inside per-test hooks below) ---

Capture Failure Artifacts
    Take Screenshot On Failure

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

TMCC 11453 Test Teardown
    Run Keyword And Ignore Error    Restore Default Sleep Timeout
    Capture Failure Artifacts

TMCC 4467 Test Setup
    Connecting to BLUphone

TMCC 4467 Test Teardown
    Run Keyword And Ignore Error    Restore Default Sleep Timeout
    Capture Failure Artifacts

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

# --- TMCC-11499: 3-way call (first call outbound) ---

TMCC 11499 Test Setup
    Connecting to BLUphone
    Remove all call logs

TMCC 11499 Test Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session
    Run Keyword And Ignore Error    Navigate To Home Screen

# --- Scenario_1: Full E2E (11547 + 11490 + 11496 + 11461) ---

Scenario 1 E2E Test Setup
    Connecting to BLUphone
    Remove all call logs
    Remove all voicemails

Scenario 1 E2E Test Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- Scenario_1: TMCC-11547 onboarding only (reset / unprovisioned device) ---

Scenario 1 Onboarding Test Setup
    [Documentation]    Connect Appium only. Do not require home/Contacts — reset devices may open Welcome/login instead.
    Open Application    ${APPIUM_URL}    &{DEVICE_AS_DICTIONARY}
    Get Driver Instance
    Sleep    3s    Allow splash / welcome / home to settle

Scenario 1 Onboarding Test Teardown
    Capture Failure Artifacts

Scenario 1 Full E2E Test Teardown
    [Documentation]    Part A+B: capture SIP on failure and clean VoIP containers after call steps.
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- Scenario_1: partial non-call run (optional) ---

Scenario 1 Non Call Test Setup
    Connecting to BLUphone

Scenario 1 Non Call Test Teardown
    Capture Failure Artifacts

# --- Scenario_2: E2E (11546 + 11490 + 11496 + 11461 + 4402 + 4412 + 1743) ---

Scenario 2 E2E Test Setup
    Connecting to BLUphone
    Remove all call logs
    Remove all voicemails

Scenario 2 E2E Test Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- Scenario_2 pieces: connect only (no wipe between pieces that share state) ---

Scenario 2 Piece Connect Setup
    Connecting to BLUphone

Scenario 2 Piece Connect Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- Scenario_1 pieces: connect only ---

Scenario 1 Piece Connect Setup
    Connecting to BLUphone

Scenario 1 Piece Connect Teardown
    Capture Failure Artifacts With SIP Logs
    Cleanup VoIP Call Session

# --- UI_UX pure-UI cases (no VoIP) ---

UI UX Test Setup
    Connecting to BLUphone

UI UX Test Teardown
    Capture Failure Artifacts
    Run Keyword And Ignore Error    Navigate To Home Screen

# --- Dial validation (keypad numbers + short call + Countly) ---

Dial Validation Test Setup
    Connecting to BLUphone
    ${yaml_text}=    Get File    ${TEST_DATA_YAML_FILE}
    ${yaml_data}=    Evaluate    yaml.safe_load($yaml_text)    modules=yaml
    ${phone_numbers}=    Set Variable    ${yaml_data}[phone_numbers]
    Should Not Be Empty    ${phone_numbers}    No phone numbers found in test data YAML.
    ${full_count}=    Get Length    ${phone_numbers}
    ${batch_size}=    Convert To Integer    ${DIAL_BATCH_SIZE}
    IF    ${batch_size} > 0
        ${phone_numbers}=    Get Slice From List    ${phone_numbers}    0    ${batch_size}
        Log    Using DIAL_BATCH_SIZE=${batch_size} of ${full_count} numbers from YAML    INFO    console=True
    ELSE
        Log    Using full list of ${full_count} phone numbers from YAML    INFO    console=True
    END
    Set Suite Variable    ${PHONE_NUMBERS}    ${phone_numbers}
    Log    Loaded ${phone_numbers.__len__()} phone numbers for this run    INFO    console=True
    Load Countly Config and Test Data

Dial Validation Test Teardown
    Run Keyword And Ignore Error    Press Speaker Button If Active    udid=${UDID}
    Run Keyword And Ignore Error    Close Post Call Review Screen
    Run Keyword And Ignore Error    Navigate To Home Screen
    Capture Failure Artifacts
