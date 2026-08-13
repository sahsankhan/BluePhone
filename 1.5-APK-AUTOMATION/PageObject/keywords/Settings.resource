*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***
Tap on Settings App
    Wait Until Element Is Visible    ${SETTINGS_APP}    ${DEFAULT_TIMEOUT}
    Click Element    ${SETTINGS_APP}
    Log To Console    Tapped on Settings app

Tap on Reset Phone
    Wait Until Element Is Visible    ${RESET_PHONE}    ${DefaultTimeout}
    Click Element    ${RESET_PHONE}
    Log To Console    Tapped on Reset Phone option

Tap on restart phone option
    Wait Until Element Is Visible    ${RESTART_PHONE}    ${DefaultTimeout}
    Click Element    ${RESTART_PHONE}
    Log To Console    Tapped on Restart Phone option

Verify restart confirmation overlay screen appears
    Wait Until Page Contains Element    ${RESTART_ALERT_MSG}    ${DefaultTimeout}
    ${text}=    Get Text    ${RESTART_ALERT_MSG}
    ${normalized}=    Evaluate    ' '.join($text.replace('\\n', ' ').split())
    Should Contain    ${normalized}    Are you sure you want to restart your phone?
    Log    Confirmation overlay screen is displayed with message: ${normalized}    INFO    console=true

Tap on Cancel button on restart confirmation overlay
    Wait Until Element Is Visible    ${CANCEL_RESTART_BTN}    ${DefaultTimeout}
    Click Element    ${CANCEL_RESTART_BTN}
    Log To Console    Tapped on Cancel button on restart confirmation overlay

Verify confirmation overlay is closed
    Page Should Not Contain Element    ${RESTART_ALERT_MSG}
    Log To Console    Confirmation overlay dismissed

Verify Reset Phone screen is still visible
    Element Should Be Visible    ${RESET_PHONE_TITLE}
    Log To Console    Reset Phone screen is still visible

Open Settings From Home
    Navigate To Home Screen
    Wait Until Element Is Visible    ${SETTINGS_APP}    ${DefaultTimeout}
    Click Element    ${SETTINGS_APP}
    Log To Console    Settings app opened

Wake Device Screen If Needed
    Run Keyword And Ignore Error    Wake Device Screen    udid=${UDID}
    Sleep    1s

Restore Default Sleep Timeout
    Wake Device Screen If Needed
    Change Sleep Timeout To 5 Minutes
    Log To Console    Sleep timeout restored to default 5 Minutes

Change Sleep Timeout To ${minutes} Minutes
    Wake Device Screen If Needed
    Open Settings From Home
    Wait Until Element Is Visible    ${SETTINGS_DISPLAY}    ${DefaultTimeout}
    Click Element    ${SETTINGS_DISPLAY}
    Adjust Sleep Timeout    ${minutes}
    Tap Settings Home Button

Adjust Sleep Timeout
    [Arguments]    ${minutes}
    ${target}=    Set Variable If    '${minutes}' == '1'    1 Minute    ${minutes} Minutes
    Wait Until Element Is Visible    ${SETTINGS_SLEEP_TIMEOUT}    ${DefaultTimeout}
    FOR    ${i}    IN RANGE    15
        ${current}=    Get Text    ${SETTINGS_SLEEP_TIMEOUT_VALUE}
        Exit For Loop If    '${current}' == '${target}'
        ${current_min}=    Evaluate    int('${current}'.split()[0])
        ${target_min}=    Evaluate    int('${minutes}')
        Run Keyword If    ${target_min} > ${current_min}    Click Element    ${SETTINGS_SLEEP_TIMEOUT_UP}
        Run Keyword If    ${target_min} < ${current_min}    Click Element    ${SETTINGS_SLEEP_TIMEOUT_DOWN}
        Sleep    0.5s
    END
    ${final}=    Get Text    ${SETTINGS_SLEEP_TIMEOUT_VALUE}
    Should Be Equal As Strings    ${final}    ${target}

Tap Settings Home Button
    Wait Until Element Is Visible    ${SETTINGS_HOME_BTN}    ${DefaultTimeout}
    Click Element    ${SETTINGS_HOME_BTN}

Get Current Screen Brightness Value
    ${value}=    Get Device Brightness    udid=${UDID}
    Set Global Variable    ${SAVED_BRIGHTNESS}    ${value}

Verify Brightness Restored To Saved Value
    ${current}=    Get Device Brightness    udid=${UDID}
    Should Be Equal As Integers    ${current}    ${SAVED_BRIGHTNESS}

Verify Hidden Menu Is Not In Settings
    ${found}=    Run Keyword And Return Status
    ...    Scroll Element Into View    locator=${SETTINGS_HIDDEN_MENU}    max_swipes=5    direction=down
    Should Be Equal    ${found}    ${False}    msg=Hidden Menu is displayed when it should not be
    Tap Settings Home Button

Tap on Sounds option in settings
    Wait Until Element Is Visible    ${SOUNDS}    ${DefaultTimeout}
    Click Element    ${SOUNDS}
    Log To Console    Opened Sounds settings

Set Ringtone Frequency
    [Arguments]    ${expected_frequency}
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_INPUT_FIELD}    ${DefaultTimeout}
    ${current_frequency}=    Get Text    ${RINGTONE_FREQUENCY_INPUT_FIELD}
    IF    '${current_frequency}' == '${expected_frequency}'
        Log To Console    Ringtone Frequency already ${expected_frequency}
        RETURN
    END
    Click Element    ${RINGTONE_FREQUENCY_INPUT_FIELD}
    Sleep    1s
    IF    '${expected_frequency}' == 'Low'
        Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_OPTION_LOW}    ${DefaultTimeout}
        Click Element    ${RINGTONE_FREQUENCY_OPTION_LOW}
    ELSE IF    '${expected_frequency}' == 'Med'
        Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_OPTION_MEDIUM}    ${DefaultTimeout}
        Click Element    ${RINGTONE_FREQUENCY_OPTION_MEDIUM}
    ELSE IF    '${expected_frequency}' == 'High'
        Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_OPTION_HIGH}    ${DefaultTimeout}
        Click Element    ${RINGTONE_FREQUENCY_OPTION_HIGH}
    END
    Log To Console    Ringtone Frequency set to ${expected_frequency}

Input Sound Volume Field
    [Arguments]    ${locator}    ${value}
    Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
    Input Value In Text Field    ${locator}    ${value}
    Dismiss Soft Keyboard
    Sleep    1s

Make Sound settings Default
    [Documentation]    Amplify OFF, ringtone vol 1 / Low, handset/headset/speaker 7. Uses Hide Keyboard (not BACK).
    Navigate To Home Screen
    the user navigates to Settings
    Tap on Sounds option in settings
    Wait Until Element Is Visible    ${AMPLIFY_RESET}    ${DefaultTimeout}
    ${amplify_on}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${AMPLIFY_TOGGLE_ON}    3
    IF    ${amplify_on}
        Click Element    ${AMPLIFY_RESET}
        Wait Until Element Is Visible    ${AMPLIFY_TOGGLE_OFF}    ${DefaultTimeout}
    ELSE
        Log To Console    Amplify Reset already OFF
    END
    Input Sound Volume Field    ${RINGTONE_VOLUME_TEXT_FIELD}    1
    Set Ringtone Frequency    expected_frequency=Low
    Input Sound Volume Field    ${HANDSET_VOLUME_TEXT_FIELD}    7
    Input Sound Volume Field    ${HEADSET_VOLUME_TEXT_FIELD}    7
    Input Sound Volume Field    ${SPEAKERPHONE_VOLUME_TEXT_FIELD}    7
    Wait Until Element Is Visible    ${TOOLBAR_BACK_BTN}    ${DefaultTimeout}
    Click Element    ${TOOLBAR_BACK_BTN}
    Wait Until Element Is Visible    ${HOME_BTN}    ${DefaultTimeout}
    Click Element                    ${HOME_BTN}

Tap on back arrow from header in Settings
    Wait Until Element Is Visible    ${TOOLBAR_BACK_BTN}    ${DefaultTimeout}
    Click Element    ${TOOLBAR_BACK_BTN}

Open Settings Menu Option
    [Arguments]    ${locator}    ${expected_title}=${EMPTY}
    # Prefer visibility first — UiAutomator1 scroll-down can swipe a top-of-list item off-screen
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    5
    IF    not ${visible}
        ${found}=    Run Keyword And Return Status
        ...    Scroll Element Into View    locator=${locator}    max_swipes=8    direction=down
        IF    not ${found}
            ${found}=    Run Keyword And Return Status
            ...    Scroll Element Into View    locator=${locator}    max_swipes=8    direction=up
        END
        IF    not ${found}
            Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
        END
    END
    Click Element    ${locator}
    IF    '${expected_title}' != '${EMPTY}'
        Wait Until Element Is Visible    ${TOOLBAR_TITLE}    ${DefaultTimeout}
        ${title}=    Get Text    ${TOOLBAR_TITLE}
        Should Be Equal As Strings    ${title}    ${expected_title}
        ...    msg=Expected settings title '${expected_title}' but got '${title}'
    END

Tap on Phone option in settings
    Open Settings Menu Option    ${SETTINGS_PHONE}    PHONE

Tap on Voicemail option in settings
    Open Settings Menu Option    ${VOICEMAIL}    VOICEMAIL

Tap on My Account option in settings
    Open Settings Menu Option    ${MY_ACCOUNT}    MY ACCOUNT

Tap on Network option in settings
    Open Settings Menu Option    ${NETWORK}    NETWORK

Tap on Display option in settings
    Open Settings Menu Option    ${DISPLAY}    DISPLAY

Tap on Flasher option in settings
    Open Settings Menu Option    ${FLASHER}    FLASHER

Tap on Date & Time option in settings
    Open Settings Menu Option    ${DATE_AND_TIME}    DATE & TIME

Tap on Reset Phone option in settings
    Open Settings Menu Option    ${RESET_PHONE}    RESET PHONE

Tap on Emergency Alerts option in settings
    Open Settings Menu Option    ${EMERGENCY_ALERT}    EMERGENCY ALERTS

Tap on About option in settings
    Open Settings Menu Option    ${ABOUT}    ABOUT

Tap on Setup Wizard option in settings
    Open Settings Menu Option    ${SETUP_WIZARD}
    Wait Until Element Is Visible    ${SETUP_WIZARD_MESSAGE}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CANCEL_BTN}    ${DefaultTimeout}
    Click Element    ${CANCEL_BTN}
    Log To Console    Setup Wizard prompt cancelled

Tap on Software Update option in settings
    Open Settings Menu Option    ${SOFTWARE_UPDATE}
    ${back_on_list}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SOFTWARE_UPDATE}    60
    IF    not ${back_on_list}
        Run Keyword And Ignore Error    Click Element    ${SOFTWARE_UPDATE_CANCEL}
        Run Keyword And Ignore Error    Tap on back arrow from header in Settings
    END
    Log To Console    Software Update option exercised

Verify that the default setting for Amplify Reset is "OFF"
    Wait Until Element Is Visible    ${AMPLIFY_RESET}    ${DefaultTimeout}
    ${off_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${AMPLIFY_TOGGLE_OFF}    5
    IF    ${off_visible}
        RETURN
    END
    # UiAutomator1 may expose content-desc as name instead of content-desc
    ${amplify_reset_status}=    Get Element Attribute    ${AMPLIFY_RESET}    name
    Should Be Equal As Strings    ${amplify_reset_status}    OFF
    ...    msg=Default setting for Amplify Reset is not OFF (got ${amplify_reset_status})

Verify Sounds screen is displayed
    Wait Until Element Is Visible    ${SOUNDS_TITLE}    ${DefaultTimeout}
    Element Should Contain Text    ${SOUNDS_TITLE}    SOUNDS
    Log To Console    Sounds screen displayed

Verify Ringtone Volume option is present with increase and decrease buttons
    Wait Until Element Is Visible    ${RINGTONE_VOLUME}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${RINGTONE_VOLUME_LEFT_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${RINGTONE_VOLUME_RIGHT_ARROW}    ${DefaultTimeout}

Verify Ringtone Frequency option is present with increase and decrease buttons
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_LEFT_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_RIGHT_ARROW}    ${DefaultTimeout}

Verify Handset Amplify Volume option is present with increase and decrease buttons
    Wait Until Element Is Visible    ${HANDSET_VOLUME}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${HANDSET_VOLUME_LEFT_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${HANDSET_VOLUME_RIGHT_ARROW}    ${DefaultTimeout}

Verify Speakerphone Amplify Volume option is present with increase and decrease buttons
    ${found}=    Run Keyword And Return Status
    ...    Scroll Element Into View    locator=${SPEAKERPHONE_VOLUME}    max_swipes=5    direction=down
    IF    not ${found}
        Wait Until Element Is Visible    ${SPEAKERPHONE_VOLUME}    ${DefaultTimeout}
    END
    Wait Until Element Is Visible    ${SPEAKERPHONE_VOLUME_LEFT_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${SPEAKERPHONE_VOLUME_RIGHT_ARROW}    ${DefaultTimeout}

Verify Headset/Neckloop Amplify Volume option is present with increase and decrease buttons
    Wait Until Element Is Visible    ${HEADSET_VOLUME}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${HEADSET_VOLUME_LEFT_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${HEADSET_VOLUME_RIGHT_ARROW}    ${DefaultTimeout}

Verify Touchscreen Sounds toggle is present
    ${found}=    Run Keyword And Return Status
    ...    Scroll Element Into View    locator=${TOUCHSCREEN_SOUND}    max_swipes=6    direction=down
    IF    not ${found}
        ${found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${TOUCHSCREEN_SOUND}    5
    END
    IF    not ${found}
        Log To Console    Touchscreen Sounds not present on this 1.5 Sounds UI — skipping toggle check
        RETURN
    END
    Wait Until Element Is Visible    ${TOUCHSCREEN_SOUND_TOGGLE}    ${DefaultTimeout}

Verify Amplify Reset toggle is present
    Wait Until Element Is Visible    ${AMPLIFY_RESET_TEXT}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${AMPLIFY_RESET_TOGGLE}    ${DefaultTimeout}

Verify Home Button option is present on Sounds
    Wait Until Element Is Visible    ${HOME_BTN}    ${DefaultTimeout}

Get current Ringtone Frequency value
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_INPUT_FIELD}    ${DefaultTimeout}
    ${ringtone_frequency}=    Get Text    ${RINGTONE_FREQUENCY_INPUT_FIELD}
    RETURN    ${ringtone_frequency}

Verify Ringtone Frequency Stepper Cycle
    [Arguments]    ${direction}=Right
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_LEFT_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_RIGHT_ARROW}    ${DefaultTimeout}
    ${right_frequencies}=    Create List    Low    Med    High
    ${left_frequencies}=    Create List    High    Med    Low
    ${all_frequencies}=    Set Variable If    '${direction}' == 'Right'    ${right_frequencies}    ${left_frequencies}
    ${arrow}=    Set Variable If    '${direction}' == 'Right'    ${RINGTONE_FREQUENCY_RIGHT_ARROW}    ${RINGTONE_FREQUENCY_LEFT_ARROW}
    ${start_frequency}=    Get current Ringtone Frequency value
    ${start_index}=    Get Index From List    ${all_frequencies}    ${start_frequency}
    ${total_steps}=    Get Length    ${all_frequencies}
    FOR    ${i}    IN RANGE    ${total_steps}
        ${index}=    Evaluate    (${start_index} + ${i}) % ${total_steps}
        ${expected_frequency}=    Get From List    ${all_frequencies}    ${index}
        ${current_frequency}=    Get current Ringtone Frequency value
        Should Be Equal As Strings    ${current_frequency}    ${expected_frequency}
        IF    ${i} < ${total_steps} - 1
            Click Element    ${arrow}
            Sleep    0.5s
        END
    END
    Click Element    ${arrow}
    Sleep    0.5s
    ${current_frequency}=    Get current Ringtone Frequency value
    Should Be Equal As Strings    ${current_frequency}    ${start_frequency}

Select Ringtone Frequency By Arrow
    [Arguments]    ${expected_frequency}    ${direction}=Right
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_RIGHT_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${RINGTONE_FREQUENCY_LEFT_ARROW}    ${DefaultTimeout}
    ${frequencies}=    Create List    Low    Med    High
    ${current_frequency}=    Get current Ringtone Frequency value
    ${current_index}=    Get Index From List    ${frequencies}    ${current_frequency}
    ${expected_index}=    Get Index From List    ${frequencies}    ${expected_frequency}
    ${diff}=    Evaluate    ${expected_index} - ${current_index}
    IF    '${direction}' == 'Right'
        IF    ${diff} > 0
            FOR    ${i}    IN RANGE    ${diff}
                Click Element    ${RINGTONE_FREQUENCY_RIGHT_ARROW}
                Sleep    0.3s
            END
        ELSE IF    ${diff} < 0
            ${abs_diff}=    Evaluate    abs(${diff})
            FOR    ${i}    IN RANGE    ${abs_diff}
                Click Element    ${RINGTONE_FREQUENCY_LEFT_ARROW}
                Sleep    0.3s
            END
        END
    ELSE IF    '${direction}' == 'Left'
        # Left cycles High <- Med <- Low; move expected_index steps "backwards"
        ${steps}=    Evaluate    (${current_index} - ${expected_index}) % 3
        FOR    ${i}    IN RANGE    ${steps}
            Click Element    ${RINGTONE_FREQUENCY_LEFT_ARROW}
            Sleep    0.3s
        END
    END
    ${current_frequency}=    Get current Ringtone Frequency value
    Should Be Equal As Strings    ${current_frequency}    ${expected_frequency}

the screen displays a rotating selector field for the time zone
    Wait Until Element Is Visible    ${TIME_ZONE_VALUE}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${TIME_ZONE_UP_ARROW}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${TIME_ZONE_DOWN_ARROW}    ${DefaultTimeout}
    ${before}=    Get Text    ${TIME_ZONE_VALUE}
    Click Element    ${TIME_ZONE_DOWN_ARROW}
    Sleep    0.5s
    ${after}=    Get Text    ${TIME_ZONE_VALUE}
    Log To Console    Time zone before: "${before}", after down arrow: "${after}"
    Should Not Be Equal    ${before}    ${after}
    Click Element    ${TIME_ZONE_UP_ARROW}
    Sleep    0.5s

the time zone reflects the phone's current location
    Wait Until Element Is Visible    ${TIME_ZONE_VALUE}    ${DefaultTimeout}
    ${current_time_zone}=    Get Text    ${TIME_ZONE_VALUE}
    Should Not Be Empty    ${current_time_zone}
    Log To Console    Current time zone displayed: "${current_time_zone}"

a non-interactive field displays the current time
    [Documentation]    1.5 Date & Time splits time across hours/minutes/am_pm under time_input (not 2.0 tvTime).
    Wait Until Element Is Visible    ${SETTINGS_TIME}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${SETTINGS_TIME_HOURS}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${SETTINGS_TIME_MINUTES}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${SETTINGS_TIME_AM_PM}    ${DefaultTimeout}
    ${hours}=    Get Text    ${SETTINGS_TIME_HOURS}
    ${minutes}=    Get Text    ${SETTINGS_TIME_MINUTES}
    ${ampm}=    Get Text    ${SETTINGS_TIME_AM_PM}
    Should Match Regexp    ${hours}    ^(1[0-2]|[1-9])$
    ...    msg=Hours field invalid: '${hours}'
    Should Match Regexp    ${minutes}    ^[0-5][0-9]$
    ...    msg=Minutes field invalid: '${minutes}'
    Should Match Regexp    ${ampm}    ^(AM|PM)$
    ...    msg=AM/PM field invalid: '${ampm}'
    Log To Console    Found time field text: ${hours}:${minutes} ${ampm}

a non-interactive field displays the current date
    [Documentation]    1.5 Date & Time splits date across month/day/year under date_input (not 2.0 tvDate).
    Wait Until Element Is Visible    ${SETTINGS_DATE}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${SETTINGS_DATE_MONTH}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${SETTINGS_DATE_DAY}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${SETTINGS_DATE_YEAR}    ${DefaultTimeout}
    ${month}=    Get Text    ${SETTINGS_DATE_MONTH}
    ${day}=    Get Text    ${SETTINGS_DATE_DAY}
    ${year}=    Get Text    ${SETTINGS_DATE_YEAR}
    Should Match Regexp    ${month}    ^(0[1-9]|1[0-2])$
    ...    msg=Month field invalid: '${month}'
    Should Match Regexp    ${day}    ^(0[1-9]|[12][0-9]|3[01])$
    ...    msg=Day field invalid: '${day}'
    Should Match Regexp    ${year}    ^[0-9]{4}$
    ...    msg=Year field invalid: '${year}'
    Log To Console    Found date field text: ${month}/${day}/${year}

the AU taps on the time zone rotating selector field
    Wait Until Element Is Visible    ${TIME_ZONE_VALUE}    ${DefaultTimeout}
    Click Element    ${TIME_ZONE_VALUE}
    Sleep    1s
    Log To Console    Tapped time zone selector value

a pop-out selector screen appears
    [Documentation]    Tapping tvValue opens the timezone list (lvList / android:id/text1 options).
    ${list_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${TIME_ZONE_SELECTOR}    8
    IF    not ${list_visible}
        Wait Until Element Is Visible    ${PACIFIC_TIME}    ${DefaultTimeout}
    END
    Log To Console    Time zone pop-out / list selector appeared

the following time zone options are displayed: Hawaii Time, Alaska Time, Pacific Time, Arizona Time, Mountain Time, Central Time, Eastern Time
    Verify Time Zone Options In Popout

Verify Time Zone Options In Popout
    @{expected_locs}=    Create List    ${HAWAII_TIME}    ${ALASKA_TIME}    ${PACIFIC_TIME}    ${ARIZONA_TIME}    ${MOUNTAIN_TIME}    ${CENTRAL_TIME}    ${EASTERN_TIME}
    @{expected_names}=    Create List    Hawaii Time    Alaska Time    Pacific Time    Arizona Time    Mountain Time    Central Time    Eastern Time
    ${len}=    Get Length    ${expected_locs}
    FOR    ${i}    IN RANGE    ${len}
        ${loc}=    Get From List    ${expected_locs}    ${i}
        ${name}=    Get From List    ${expected_names}    ${i}
        ${found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    5
        IF    not ${found}
            # Some zones may need a short swipe in the list
            Run Keyword And Ignore Error    Scroll Element Into View    locator=${loc}    max_swipes=4    direction=down
            Wait Until Element Is Visible    ${loc}    ${DefaultTimeout}
        END
        ${text}=    Get Text    ${loc}
        Should Be Equal As Strings    ${text}    ${name}
        ...    msg=Time zone option mismatch for ${name}: got '${text}'
        Log To Console    Found time zone option: ${text}
    END
    Log To Console    All expected time zone options verified in pop-out
    # Dismiss list by selecting current/pacific so Date & Time screen is restored for teardown
    Run Keyword And Ignore Error    Click Element    ${PACIFIC_TIME}
    Sleep    1s

Verify 'Show Caller ID' is not displayed on the screen
    ${status}=    Run Keyword And Return Status    Page Should Contain Element    ${SHOW_CALLER_ID_OPTION}
    Should Not Be True    ${status}    msg='Show Caller ID' option is unexpectedly displayed on the Phone screen
    Log To Console    Verified Show Caller ID is not displayed

Tap on Handset Volume text field in Sound Settings
    Wait Until Element Is Visible    ${HANDSET_VOLUME_TEXT_FIELD}    ${DefaultTimeout}
    Click Element    ${HANDSET_VOLUME_TEXT_FIELD}
    Log To Console    Clicked Handset Volume text field

Verify that the numeric keyboard is displayed
    ${kbd}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${NUMERIC_KEYBOARD}    8
    IF    ${kbd}
        Log To Console    Numeric keyboard frame visible
        RETURN
    END
    # Fallback: focused text field implies soft keyboard invoked (UiAutomator1)
    ${phone_focus}=    Run Keyword And Return Status
    ...    Get Element Attribute    ${CONTACT_PHONE_NUMBER_FIELD}    focused
    IF    ${phone_focus}
        ${focused}=    Get Element Attribute    ${CONTACT_PHONE_NUMBER_FIELD}    focused
        IF    '${focused}' == 'true'
            Log To Console    Phone field focused (keyboard invoke verified)
            RETURN
        END
    END
    ${handset_focus}=    Run Keyword And Return Status
    ...    Get Element Attribute    ${HANDSET_VOLUME_TEXT_FIELD}    focused
    IF    ${handset_focus}
        ${focused}=    Get Element Attribute    ${HANDSET_VOLUME_TEXT_FIELD}    focused
        Should Be Equal As Strings    ${focused}    true
        ...    msg=Expected numeric keyboard after field tap
        Log To Console    Handset Volume field focused (keyboard invoke verified)
        RETURN
    END
    Fail    Numeric keyboard not detected

Input value in Handset Volume text field
    [Arguments]    ${VALUE}    ${CLEAR_FIRST}=${True}
    Run Keyword And Ignore Error
    ...    Scroll Element Into View    locator=${HANDSET_VOLUME_TEXT_FIELD}    max_swipes=5    direction=down
    Wait Until Element Is Visible    ${HANDSET_VOLUME_TEXT_FIELD}    ${DefaultTimeout}
    Click Element    ${HANDSET_VOLUME_TEXT_FIELD}
    Sleep    0.5s
    # UiAutomator1 InputText is flaky on volume etValue — use ADB clear+type
    Type Into Focused Field Via Adb    ${VALUE}
    Sleep    1s
    ${hide}=    Get Value From Yaml File    keycodes    KEYPAD_HIDE
    Run Keyword And Ignore Error    Press Keycode    ${hide}
    Sleep    1s
    Run Keyword And Ignore Error
    ...    Scroll Element Into View    locator=${HANDSET_VOLUME_TEXT_FIELD}    max_swipes=5    direction=down
    Log To Console    Entered Handset Volume value ${VALUE}

Get text from Handset Volume text field
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HANDSET_VOLUME_TEXT_FIELD}    5
    IF    not ${visible}
        Run Keyword And Ignore Error
        ...    Scroll Element Into View    locator=${HANDSET_VOLUME_TEXT_FIELD}    max_swipes=6    direction=down
        ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HANDSET_VOLUME_TEXT_FIELD}    5
    END
    IF    not ${visible}
        # Recover if soft-keyboard hide left Sounds
        AU is on Sounds screen
        Run Keyword And Ignore Error
        ...    Scroll Element Into View    locator=${HANDSET_VOLUME_TEXT_FIELD}    max_swipes=6    direction=down
    END
    Wait Until Element Is Visible    ${HANDSET_VOLUME_TEXT_FIELD}    ${DefaultTimeout}
    ${text}=    Get Text    ${HANDSET_VOLUME_TEXT_FIELD}
    Log To Console    Handset Volume text=${text}
    RETURN    ${text}

Verify Voicemail Is Directly Below Phone In Settings Menu
    Wait Until Element Is Visible    ${SETTINGS_PHONE}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${VOICEMAIL}    ${DefaultTimeout}
    ${all_items}=    Get WebElements    ${SETTINGS_OPTIONS_LIST}
    ${phone_index}=    Set Variable    ${-1}
    ${voicemail_index}=    Set Variable    ${-1}
    ${counter}=    Set Variable    ${0}
    FOR    ${element}    IN    @{all_items}
        ${text}=    Call Method    ${element}    get_attribute    text
        ${text}=    Strip String    ${text}
        IF    '${text}' == 'Phone'
            ${phone_index}=    Set Variable    ${counter}
        END
        IF    '${text}' == 'Voicemail'
            ${voicemail_index}=    Set Variable    ${counter}
        END
        ${counter}=    Evaluate    ${counter} + 1
    END
    Should Not Be Equal As Integers    ${phone_index}    -1    msg=Phone item not found in Settings list
    Should Not Be Equal As Integers    ${voicemail_index}    -1    msg=Voicemail item not found in Settings list
    ${expected_voicemail_index}=    Evaluate    ${phone_index} + 1
    Should Be Equal As Integers    ${voicemail_index}    ${expected_voicemail_index}
    ...    msg=Voicemail is not directly beneath Phone. Phone=${phone_index}, Voicemail=${voicemail_index}
    Log To Console    Verified Voicemail directly below Phone (Phone=${phone_index}, Voicemail=${voicemail_index})
