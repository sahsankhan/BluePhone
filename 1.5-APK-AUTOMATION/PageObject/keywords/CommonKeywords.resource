*** Settings ***
Library    OperatingSystem
Library    JSONLibrary
Library    Collections
Library    DateTime
Library    String
Library    ${CURDIR}/../../../panacea_runtime/MobAppTestLibrary/
Library    ${CURDIR}/../../../panacea_runtime/ApiTestLibrary/
Library    ${CURDIR}/../../../Utility

# Locators Files
Resource   ${CURDIR}/../../PageObject/locators/SettingsLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/HomeScreenLocators.resource    
Resource   ${CURDIR}/../../PageObject/locators/CallLogLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/CommanLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/PostCallScreenLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/VoicemailLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/ContactsLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/FavoritesLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/HelpVideosLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/SettingsPageLocators.resource
Resource   ${CURDIR}/../../PageObject/locators/OnboardingLocators.resource


# Class Files
Resource   ${CURDIR}/../../PageObject/keywords/HomeScreen_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/CallHandler_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/CallHandler.resource
Resource   ${CURDIR}/../../PageObject/keywords/PostCall_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/PostCall.resource
Resource   ${CURDIR}/../../PageObject/keywords/CallLog_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/CallLog.resource
Resource   ${CURDIR}/../../PageObject/keywords/Settings_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/Settings.resource
Resource   ${CURDIR}/../../PageObject/keywords/Voicemail.resource
Resource   ${CURDIR}/../../PageObject/keywords/Contacts.resource
Resource   ${CURDIR}/../../PageObject/keywords/Contacts_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/Favorites.resource
Resource   ${CURDIR}/../../PageObject/keywords/Favorites_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/HelpVideos.resource
Resource   ${CURDIR}/../../PageObject/keywords/HelpVideos_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/Display_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/Onboarding_Steps.resource
Resource   ${CURDIR}/../../PageObject/keywords/Dial_Validation.resource

*** Variables ***
${TEST_DATA_YAML_FILE}    ${CURDIR}/../../ConfigFiles/testdata.yaml
${VOIP_CONFIG_YAML_FILE}    ${CURDIR}/../../ConfigFiles/Voip_Config.yaml
${CONFIG_YAML_FILE}    ${CURDIR}/../../ConfigFiles/config.yaml
${LAMDA_CONFIG_YAML_FILE}    ${CURDIR}/../../ConfigFiles/lambda_config.yaml
${DEVICE_DETAILS_JSON}    ${CURDIR}/../../ConfigFiles/deviceDetails.json
${SCRIPT2_CAPTION_FILE_PATH}    ${CURDIR}/../../ConfigFiles/Script2_caption.txt
${DEVICE_NAME}    None
${REPORT_DIR}     ${CURDIR}/../../TestResults
${DEVICE_AS_DICTIONARY}    None
${APPIUM_URL}    None
${UDID}    None
${ADB_PROCESS}    None
${ALIAS}    InboundCall
${actual_status_code}    None
${DefaultTimeout}    20
${VOIP_CFG}    None
${DID_1}    None
${DID_1_PASSWORD}    None
${DID_2}    None
${DID_2_PASSWORD}    None
${CALLEE_NUMBER}    None
${BLUE_DEVICE_ID}    None
${USERNAME}    None
${ACCOUNT_PASSWORD}    None
${COUNTLY_BASE_URL}        None
${COUNTLY_API_KEY}         None
${COUNTLY_APP_ID}          None
${DIAL_BATCH_SIZE}         0

*** Keywords ***

Get Value From Yaml File
   [Arguments]    ${section}    ${key}
   ${yaml_string}=    Get File    ${TEST_DATA_YAML_FILE}    # Read YAML file as string
   ${data}=    Evaluate    __import__('yaml').safe_load('''${yaml_string}''')  # Parse YAML
   ${section_data}=    Get From Dictionary    ${data}    ${section}
   ${value}=    Get From Dictionary    ${section_data}    ${key}
   RETURN    ${value}

Suite Setup
    Load Device Info    ${DEVICE_NAME}

Suite Teardown
    Log    Ending Test Suite: ${SUITE_NAME}

Connecting to BLUphone
    Run Keywords
        Open Application
        ...    ${APPIUM_URL}
        ...    &{DEVICE_AS_DICTIONARY}
        Navigate To Home Screen
        Wait Until Keyword Succeeds    180    5    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}
    Get Driver Instance

Navigate To Home Screen
    ${on_home}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    5
    Return From Keyword If    ${on_home}
    Run Keyword And Ignore Error    Wake Device Screen    udid=${UDID}
    Sleep    1s
    FOR    ${attempt}    IN RANGE    1    5
        Run Keyword And Ignore Error    Wait Until Element Is Visible    ${VM_BACK_BUTTON}    2
        Run Keyword And Ignore Error    Click Element    ${VM_BACK_BUTTON}
        Run Keyword And Ignore Error    Wait Until Element Is Visible    ${VM_HOME_BUTTON}    2
        Run Keyword And Ignore Error    Click Element    ${VM_HOME_BUTTON}
        Run Keyword And Ignore Error    Wait Until Element Is Visible    ${HOME_BUTTON}    2
        Run Keyword And Ignore Error    Click Element    ${HOME_BUTTON}
        ${on_home}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    5
        Exit For Loop If    ${on_home}
    END
    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}

Load Device Info
    [Arguments]    ${DEVICE_NAME}

    ${json_data}=    Load JSON From File    ${DEVICE_DETAILS_JSON}

    ${device}=       Get From Dictionary    ${json_data}    ${DEVICE_NAME}
    Set Global Variable    ${DEVICE_AS_DICTIONARY}    ${device}

    ${UDID}=    Get From Dictionary    ${device}    udid
    Set Global Variable    ${UDID}    ${UDID}

    ${APPIUM_URL}=    Get From Dictionary    ${device}    appium-url
    Set Global Variable    ${APPIUM_URL}    ${APPIUM_URL}

    ${APP_PACKAGE}=    Get From Dictionary    ${device}    appPackage
    Set Global Variable    ${APP_PACKAGE}    ${APP_PACKAGE}

    ${APP_ACTIVITY}=    Get From Dictionary    ${device}    appActivity
    Set Global Variable    ${APP_ACTIVITY}    ${APP_ACTIVITY}

    ${BLUE_DEVICE_ID}=    Get From Dictionary    ${device}    blueDeviceId
    Set Global Variable    ${BLUE_DEVICE_ID}    ${BLUE_DEVICE_ID}

    ${USERNAME}=    Get From Dictionary    ${device}    userName
    Set Global Variable    ${USERNAME}    ${USERNAME}

    ${CALLEE_NUMBER}=    Get From Dictionary    ${device}    calleeNumber
    Set Global Variable    ${CALLEE_NUMBER}    ${CALLEE_NUMBER}

    ${DID_1}=    Get From Dictionary    ${device}    did_1
    Set Global Variable    ${DID_1}    ${DID_1}

    ${DID_1_PASSWORD}=    Get From Dictionary    ${device}    did_1_password
    Set Global Variable    ${DID_1_PASSWORD}    ${DID_1_PASSWORD}

    ${DID_2}=    Get From Dictionary    ${device}    did_2
    Set Global Variable    ${DID_2}    ${DID_2}

    ${DID_2_PASSWORD}=    Get From Dictionary    ${device}    did_2_password
    Set Global Variable    ${DID_2_PASSWORD}    ${DID_2_PASSWORD}
    
    Set Log Level    NONE
    ${ACCOUNT_PASSWORD}=    Get From Dictionary    ${device}    accountPassword
    Set Global Variable    ${ACCOUNT_PASSWORD}    ${ACCOUNT_PASSWORD}
    Set Log Level    DEBUG

Dial Number With Keycodes
    [Arguments]    ${number_to_dial}
    ${digits}=     Convert To List    ${number_to_dial}
    FOR    ${digit}    IN    @{digits}
        ${key_name}=    Set Variable    KEY_EVENT_${digit}
        ${keycode}=     Get Value From Yaml File    keycodes    ${key_name}
        Press Keycode   ${keycode}
        Sleep           0.3s    # Given intervel after pressing single number
    END

Save SIP Logs To File
    [Arguments]    ${sip_logs}    ${blue_device_id}
    ${log_dir}=      Set Variable    ${REPORT_DIR}
    Create Directory    ${log_dir}
    ${file_path}=    Set Variable    ${log_dir}/sip_logs_${blue_device_id}.log
    Create File    ${file_path}    ${sip_logs}
    Log    SIP logs saved to: ${file_path}

Take Screenshot On Failure
    ${safe_name}=    Replace String    ${TEST_NAME}    :    -
    ${safe_name}=    Replace String    ${safe_name}    /    -
    Run Keyword If Test Failed    Capture Page Screenshot    ${REPORT_DIR}/${safe_name}_failure.png
    Run Keyword If Test Failed    Snap Screen    FAILURE

Snap Screen
    [Documentation]    adb screencap + uiautomator texts + classify. Prints to console; images under TestResults/live_snap.
    [Arguments]    ${label}=screen
    ${udid}=    Get Device Udid
    ${repo}=    Normalize Path    ${CURDIR}${/}..${/}..${/}..
    ${script}=    Set Variable    ${repo}${/}1.5-APK-AUTOMATION${/}TestResults${/}snap_screen.py
    ${out_dir}=    Set Variable    ${REPORT_DIR}${/}live_snap
    Create Directory    ${out_dir}
    ${py}=    Set Variable    ${repo}${/}panacea_env${/}Scripts${/}python.exe
    ${rc}    ${output}=    Run And Return Rc And Output    "${py}" -u "${script}" ${udid} "${label}" "${out_dir}"
    Log To Console    ${output}
    ${class}=    Set Variable    UNKNOWN
    ${m}=    Get Regexp Matches    ${output}    SCREEN_CLASS=(\\S+)    1
    ${n}=    Get Length    ${m}
    IF    ${n} > 0
        ${class}=    Get From List    ${m}    0
    END
    RETURN    ${class}

Onboarding Already Past Consents
    [Documentation]    True if device is past consent WebViews (DOB/address/home/registration/etc).
    ${ssn}=    Run Keyword And Return Status    Page Should Contain Element    ${SSN_FIELD}
    IF    ${ssn}    RETURN    ${True}
    ${street}=    Run Keyword And Return Status    Page Should Contain Element    ${STREET_ADDRESS}
    IF    ${street}    RETURN    ${True}
    ${home}=    Run Keyword And Return Status    Page Should Contain Element    ${CONTACTS_APP_ICON}
    IF    ${home}    RETURN    ${True}
    ${accept}=    Run Keyword And Return Status    Page Should Contain Element    ${REGISTRATION_ACCEPT_BUTTON}
    IF    ${accept}    RETURN    ${True}
    ${yes}=    Run Keyword And Return Status    Page Should Contain Element    ${SETUP_NEXT_BUTTON}
    IF    ${yes}    RETURN    ${True}
    ${addr_hint}=    Run Keyword And Return Status    Page Should Contain Text    correct
    IF    ${addr_hint}    RETURN    ${True}
    ${zip}=    Run Keyword And Return Status    Page Should Contain Element    ${ZIP_CODE}
    IF    ${zip}    RETURN    ${True}
    RETURN    ${False}

Get Device Udid
    ${udid}=    Set Variable    ${UDID}
    IF    '${udid}' == 'None' or '${udid}' == ''
        ${udid}=    Get From Dictionary    ${DEVICE_AS_DICTIONARY}    udid
    END
    RETURN    ${udid}

Dismiss Soft Keyboard
    [Documentation]    Prefer Hide Keyboard. Never use BACK — BACK leaves DOB / opens Oops / app chooser.
    ...    Never tap arbitrary screen coords — DOB instructions contain links that open ResolverActivity.
    Run Keyword And Ignore Error    Hide Keyboard
    Sleep    0.3s

Dismiss Oops Overlay If Present
    [Documentation]    OopsVoipWizardErrorActivity — No phone service. Button text is Close (id activity_setup_prompt_button_no).
    ...    Prefer Close tap; never BACK (leaves DOB / opens chooser).
    ${udid}=    Get Device Udid
    FOR    ${i}    IN RANGE    4
        ${oops_txt}=    Run Keyword And Return Status    Page Should Contain Text    Oops
        ${oops_act}=    Run Keyword And Return Status    Page Should Contain Text    phone service
        IF    not ${oops_txt} and not ${oops_act}
            RETURN
        END
        ${closed}=    Run Keyword And Return Status    Click Element    id=clrcap.CCClient:id/activity_setup_prompt_button_no
        IF    not ${closed}
            ${closed}=    Run Keyword And Return Status    Click Element    xpath=//*[@text='Close' or @text='CLOSE']
        END
        IF    not ${closed}
            # Close button sits near bottom-center on 600x1024
            Run    adb -s ${udid} shell input tap 300 920
            ${closed}=    Set Variable    ${True}
        END
        IF    ${closed}
            Log To Console    Closed Oops
            Sleep    0.5s
        END
    END

Type Into Focused Field Via Adb
    [Arguments]    ${text}
    [Documentation]    Clear then type ONCE via host adb (do not also Input Text — double length disables Next).
    ${udid}=    Get Device Udid
    FOR    ${i}    IN RANGE    8
        Run    adb -s ${udid} shell input keyevent 67
    END
    Run    adb -s ${udid} shell input text ${text}
    Sleep    0.25s

Ensure Element Visible Not Covered By Keyboard
    [Arguments]    ${locator}    ${timeout}=20
    [Documentation]    If locator not visible, dismiss Oops / soft keyboard and retry.
    ...    Do NOT press BACK or tap random coords (opens Oops / app chooser on DOB).
    Dismiss Oops Overlay If Present
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    2
    IF    ${visible}
        RETURN
    END
    Dismiss Soft Keyboard
    Wait Until Keyword Succeeds    ${timeout}    1s    Wait Until Element Is Visible    ${locator}    2
    Log To Console    Spot: field visible after Hide Keyboard

the phone is on-hook
    ${blue_header}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${BLUE_HEADER}    5
    Run Keyword If    not ${blue_header}    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}
    Log To Console    Verified phone is on-hook on home screen

captions for the call are displayed
    Compare Captions    duration=120

Get Post Call Contact Name
    ${expected_name}=    Get Value From Yaml File    user    verificationName2
    Wait Until Element Is Visible    ${POST_CALL_CONTACT_NAME}    30
    ${actual_name}=    Get Text    ${POST_CALL_CONTACT_NAME}
    Log    Post-call contact name: ${actual_name}    console=True
    Should Be Equal    ${actual_name}    ${expected_name}

Get Callee Number From Home Screen
    [Documentation]    Reads AU DID from home header. Falls back to deviceDetails calleeNumber if UI missing.
    Navigate To Home Screen
    ${visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${DEVICE_NUMBER}    30
    IF    ${visible}
        ${actual_callee_number}=    Get Text    ${DEVICE_NUMBER}
        Log To Console    Raw Callee number: ${actual_callee_number}
        ${CALLEE_NUMBER}=    Convert To Plain Number    ${actual_callee_number}
        Set Global Variable    ${CALLEE_NUMBER}    ${CALLEE_NUMBER}
        Log To Console    Callee Number: ${CALLEE_NUMBER}
        RETURN    ${CALLEE_NUMBER}
    END
    Should Not Be Equal    ${CALLEE_NUMBER}    None    msg=DEVICE_NUMBER not on home and CALLEE_NUMBER unset in deviceDetails
    Log To Console    Using CALLEE_NUMBER from deviceDetails: ${CALLEE_NUMBER}
    RETURN    ${CALLEE_NUMBER}

Make Post Call Review Toggle On
    [Documentation]    Phone → Caption Settings: Post-call Review ON, Auto-save ON, Default Settings ON.
    Navigate To Home Screen
    Wait Until Element Is Visible    ${SETTINGS_APP}    ${DefaultTimeout}
    Click Element                    ${SETTINGS_APP}
    Wait Until Element Is Visible    ${SETTINGS_PHONE}    ${DefaultTimeout}
    Click Element                    ${SETTINGS_PHONE}
    Wait Until Element Is Visible    ${CAPTION_SETTING}    ${DefaultTimeout}
    Click Element                    ${CAPTION_SETTING}
    ${PostCallAttributeValue}=        Get Element Attribute    ${POST_CALL_REVIEW_TOGGLE}    content-desc
    Run Keyword If    '${PostCallAttributeValue}'.lower() == 'off'
    ...    Click Element    ${POST_CALL_REVIEW_TOGGLE}
    Set Auto Save Captions To ON
    ${CaptionSettingAttributeValue}=    Get Element Attribute    ${CAPTION_SETTINGS_TOGGLE}    content-desc
    Run Keyword If    '${CaptionSettingAttributeValue}'.lower() == 'off'
    ...    Click Element    ${CAPTION_SETTINGS_TOGGLE}
    Wait Until Element Is Visible    ${HOME_BTN}    ${DefaultTimeout}
    Click Element                    ${HOME_BTN}

Set Auto Save Captions To ${STATUS}
    Wait Until Element Is Visible    ${AUTO_SAVE_CAPTIONS_TOGGLE}    ${DefaultTimeout}
    ${current_status}=    Get Element Attribute    ${AUTO_SAVE_CAPTIONS_TOGGLE}    content-desc
    Run Keyword If    '${current_status}'.lower() != '${STATUS}'.lower()
    ...    Click Element    ${AUTO_SAVE_CAPTIONS_TOGGLE}
    Log To Console    Auto-save Captions set to ${STATUS}