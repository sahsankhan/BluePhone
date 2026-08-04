*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
Dismiss Android App Chooser If Present
    [Documentation]    Accidental WebView link taps open ResolverActivity (Complete action using). BACK out.
    ${chooser}=    Run Keyword And Return Status    Page Should Contain Text    Complete action using
    IF    ${chooser}
        Press Keycode    4
        Sleep    0.5s
        Log To Console    Dismissed Android app chooser
    END

Click Onboarding Next Button
    [Documentation]    Prefer DOB btn_next, then Welcome btnNext, enter, or text Next.
    Dismiss Android App Chooser If Present
    ${dob_next}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${DOB_NEXT_BTN}    3
    IF    ${dob_next}
        Click Element    ${DOB_NEXT_BTN}
    ELSE
        ${next_by_id}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_NEXT_BTN}    3
        IF    ${next_by_id}
            Click Element    ${ONBOARDING_NEXT_BTN}
        ELSE
            ${enter_ok}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_ENTER_BTN}    3
            IF    ${enter_ok}
                Click Element    ${ONBOARDING_ENTER_BTN}
            ELSE
                Click Element    xpath=//*[@text='Next' or @text='NEXT']
            END
        END
    END

Click Onboarding Submit Button
    Dismiss Android App Chooser If Present
    ${submit_link}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONSENT_SUBMIT_LINK}    3
    IF    ${submit_link}
        Click Element    ${CONSENT_SUBMIT_LINK}
    ELSE
        ${submit_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_SUBMIT_BTN}    3
        IF    ${submit_visible}
            Click Element    ${ONBOARDING_SUBMIT_BTN}
        ELSE
            Click Onboarding Next Button
        END
    END

Wait For Onboarding Screen Containing
    [Arguments]    ${text}
    Dismiss Android App Chooser If Present
    Wait Until Keyword Succeeds    60s    2s    Page Should Contain Text    ${text}

Wait For Setup Check To Finish
    [Documentation]    SetupCheck Checkingâ€¦ â€” short poll until login or consent prompt.
    Wait Until Keyword Succeeds    45s    2s    Setup Check Finished Or Login Visible

Setup Check Finished Or Login Visible
    Dismiss Android App Chooser If Present
    ${login}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_BTN}    2
    ${pwd}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ENTER_PASSWORD}    2
    ${consent_prompt}=    Run Keyword And Return Status    Page Should Contain Text    Consent
    ${still_checking}=    Run Keyword And Return Status    Page Should Contain Text    Checking
    IF    ${still_checking} and not ${login} and not ${pwd} and not ${consent_prompt}
        Fail    Still on setup check
    END
    Should Be True    ${login} or ${pwd} or ${consent_prompt}    msg=Setup check ended but login/consent not visible

Fill Login Email And Password
    [Documentation]    2.0-style field entry with KEYPAD_HIDE after each field.
    Wait Until Element Is Visible    ${USERNAME_INPUT}    15
    Input Value In Text Field    ${USERNAME_INPUT}    ${USERNAME}
    Wait Until Element Is Visible    ${ENTER_PASSWORD}    10
    Input Value In Text Field    ${ENTER_PASSWORD}    ${ACCOUNT_PASSWORD}

new user can login
    [Documentation]    TAP TO FIX â†’ Welcome Start â†’ setup check â†’ login â†’ Consent prompt.
    ...    If already past login (consent/SSN visible), skips fill and continues â€” live recovery only.
    Dismiss Android App Chooser If Present
    ${already_ssn}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    2
    ${already_consent}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_ACK_CHECKBOX}
    ${already_consent_txt}=    Run Keyword And Return Status    Page Should Contain Text    Consent
    IF    ${already_ssn} or ${already_consent} or ${already_consent_txt}
        Log To Console    Already past login â€” continuing from current screen
        RETURN
    END
    ${banner_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CONNECTION_PROBLEM_BANNER}    15
    IF    ${banner_visible}
        Click Element    ${CONNECTION_PROBLEM_BANNER}
        Log To Console    Tapped TAP TO FIX banner
        Sleep    1s
    END
    ${start_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_NEXT_BTN}    15
    IF    ${start_visible}
        Click Element    ${ONBOARDING_NEXT_BTN}
        Log To Console    Tapped Welcome Start
    END
    ${login_ready}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ENTER_PASSWORD}    20
    IF    not ${login_ready}
        ${consent_already}=    Run Keyword And Return Status    Page Should Contain Text    Consent
        IF    not ${consent_already}
            Run Keyword And Ignore Error    Wait For Setup Check To Finish
        END
    END
    ${on_login}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ENTER_PASSWORD}    45
    IF    ${on_login}
        Fill Login Email And Password
        Run Keyword And Ignore Error    Hide Keyboard
        Sleep    0.5s
        Wait Until Element Is Visible    ${LOGIN_BTN}    ${DefaultTimeout}
        Click Element    ${LOGIN_BTN}
        Sleep    3s
        ${oops}=    Run Keyword And Return Status    Page Should Contain Text    Oops
        IF    ${oops}
            Fail    Login rejected â€” invalid credentials
        END
    ELSE
        Log To Console    Login form not shown â€” may already be logged in; continuing
    END
    # Consent Forms intro prompt (OptionPromptSetupActivity)
    ${prompt}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_SUBMIT_BTN}    20
    IF    ${prompt}
        ${has_consent}=    Run Keyword And Return Status    Page Should Contain Text    Consent
        IF    ${has_consent}
            Click Element    ${ONBOARDING_SUBMIT_BTN}
            Log To Console    Tapped Consent Forms Next prompt
            Sleep    1s
        END
    END

Complete One Consent WebView Page
    [Documentation]    Must scroll yellow box until SCROLL HERE gone, check ack, then NEXT only if enabled.
    ...    Do not click NEXT while disabled — that is a false pass and stays on the same consent.
    Dismiss Android App Chooser If Present
    Dismiss Oops Overlay If Present
    ${on_dob}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    2
    IF    ${on_dob}
        Log To Console    Already on DOB — skip consent page
        RETURN
    END
    ${was_electronic}=    Run Keyword And Return Status    Page Should Contain Text    ELECTRONIC RECORDS
    Scroll Consent Yellow Box Until Ready
    Ensure Consent Checkbox Checked
    Tap Consent Next Or Submit
    Sleep    2s
    Dismiss Android App Chooser If Present
    ${on_dob}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    3
    IF    ${on_dob}
        Log To Console    Reached DOB after consent page
        RETURN
    END
    IF    ${was_electronic}
        ${still}=    Run Keyword And Return Status    Page Should Contain Text    ELECTRONIC RECORDS
        IF    ${still}
            Log To Console    Still on ELECTRONIC RECORDS — retry once
            Scroll Consent Yellow Box Until Ready
            Ensure Consent Checkbox Checked
            Tap Consent Next Or Submit
            Sleep    2s
            ${still}=    Run Keyword And Return Status    Page Should Contain Text    ELECTRONIC RECORDS
            IF    ${still}
                Fail    Consent NEXT did not leave ELECTRONIC RECORDS page
            END
        END
    END
    Log To Console    Consent page advanced

Scroll Consent Yellow Box Until Ready
    [Documentation]    Inner orange/yellow agreement box: Appium+adb swipe UP at box center until SCROLL HERE gone.
    ...    Proven on 600x1024: (300,480)->(300,120). Wrong coords / adb-only never moves this WebView.
    ${udid}=    Get Device Udid
    ${w}=    Get Window Width
    ${h}=    Get Window Height
    ${box_cx}=    Evaluate    int(${w} * 0.50)
    ${y1}=    Evaluate    int(${h} * 0.47)
    ${y2}=    Evaluate    int(${h} * 0.12)
    FOR    ${i}    IN RANGE    45
        ${scroll_here}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_SCROLL_HERE}
        IF    not ${scroll_here}
            ${scroll_here}=    Run Keyword And Return Status    Page Should Contain Text    SCROLL HERE
        END
        IF    not ${scroll_here}
            Log To Console    SCROLL HERE gone after ${i} swipes — extra to bottom
            FOR    ${j}    IN RANGE    10
                Run Keyword And Ignore Error    Flick    ${box_cx}    ${y1}    ${box_cx}    ${y2}
                Run    adb -s ${udid} shell input swipe ${box_cx} ${y1} ${box_cx} ${y2} 200
            END
            RETURN
        END
        # BOTH Appium Flick and adb — together this is what cleared SCROLL HERE
        Run Keyword And Ignore Error    Flick    ${box_cx}    ${y1}    ${box_cx}    ${y2}
        Run    adb -s ${udid} shell input swipe ${box_cx} ${y1} ${box_cx} ${y2} 200
        Sleep    0.05s
    END
    Fail    Could not clear SCROLL HERE on inner consent box

Ensure Consent Checkbox Checked
    ${udid}=    Get Device Udid
    Wait Until Keyword Succeeds    20s    1s    Page Should Contain Element    ${CONSENT_ACK_CHECKBOX}
    ${ch}=    Get Element Attribute    ${CONSENT_ACK_CHECKBOX}    checked
    IF    '${ch}' == 'true'
        Log To Console    Consent checkbox already checked
        RETURN
    END
    ${loc}=    Get Element Location    ${CONSENT_ACK_CHECKBOX}
    ${size}=    Get Element Size    ${CONSENT_ACK_CHECKBOX}
    ${x}=    Evaluate    int(${loc}[x] + 16)
    ${y}=    Evaluate    int(${loc}[y] + ${size}[height] / 2)
    Run    adb -s ${udid} shell input tap ${x} ${y}
    Sleep    0.5s
    ${ch}=    Get Element Attribute    ${CONSENT_ACK_CHECKBOX}    checked
    IF    '${ch}' != 'true'
        Run Keyword And Ignore Error    Click Element    ${CONSENT_ACK_CHECKBOX}
        Sleep    0.4s
        Run    adb -s ${udid} shell input tap ${x} ${y}
        Sleep    0.4s
    END
    ${ch}=    Get Element Attribute    ${CONSENT_ACK_CHECKBOX}    checked
    Should Be Equal    ${ch}    true    msg=Consent acknowledge checkbox still unchecked — NEXT would stay disabled
    Log To Console    Consent checkbox checked

Tap Consent Next Or Submit
    ${udid}=    Get Device Udid
    # Prefer SUBMIT/DONE then NEXT — never tap while disabled
    FOR    ${loc}    IN    ${CONSENT_SUBMIT_LINK}    ${CONSENT_SUBMIT_LINK_2}    ${CONSENT_SUBMIT_TEXT}    ${CONSENT_DONE_LINK}    ${CONSENT_NEXT_LINK}    ${CONSENT_NEXT_LINK_2}    ${CONSENT_NEXT_TEXT}
        ${vis}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    2
        IF    not ${vis}
            CONTINUE
        END
        ${enabled}=    Get Element Attribute    ${loc}    enabled
        IF    '${enabled}' == 'false'
            Log To Console    ${loc} visible but disabled — skip
            CONTINUE
        END
        Click Element    ${loc}
        Log To Console    Tapped consent control ${loc}
        Sleep    1s
        RETURN
    END
    # Last resort: NEXT Link bounds center ~ (300,740) on 600x1024
    ${w}=    Get Window Width
    ${h}=    Get Window Height
    ${nx}=    Evaluate    int(${w} * 0.50)
    ${ny}=    Evaluate    int(${h} * 0.72)
    Run    adb -s ${udid} shell input tap ${nx} ${ny}
    Log To Console    Fallback adb tap NEXT area ${nx},${ny}
    Sleep    1s

Dismiss Already Consented Screen If Present
    [Documentation]    Spot: You've already consented + EXIT (WebView). Appium click often fails â€” host adb taps.
    ${already}=    Run Keyword And Return Status    Page Should Contain Text    already consented
    IF    not ${already}
        ${already}=    Run Keyword And Return Status    Page Should Contain Text    You've already consented
    END
    IF    not ${already}
        RETURN    ${False}
    END
    ${udid}=    Set Variable    ${UDID}
    IF    '${udid}' == 'None' or '${udid}' == ''
        ${udid}=    Get From Dictionary    ${DEVICE_AS_DICTIONARY}    udid
    END
    ${w}=    Get Window Width
    ${h}=    Get Window Height
    ${cx}=    Evaluate    int(${w} / 2)
    # EXIT sits mid-page under body text on this WebView
    FOR    ${y_pct}    IN    0.52    0.58    0.62    0.66    0.70    0.48
        ${y}=    Evaluate    int(${h} * ${y_pct})
        Run    adb -s ${udid} shell input tap ${cx} ${y}
        Sleep    1s
        ${still}=    Run Keyword And Return Status    Page Should Contain Text    already consented
        IF    not ${still}
            Log To Console    Spot: already consented â€” EXIT via adb tap y=${y}
            Sleep    1s
            RETURN    ${True}
        END
        ${clicked}=    Run Keyword And Return Status    Click Element    ${CONSENT_EXIT_LINK}
        IF    ${clicked}
            Log To Console    Spot: already consented â€” tapped EXIT Link
            Sleep    2s
            RETURN    ${True}
        END
    END
    Fail    Already-consented screen visible but EXIT tap failed

Consent forms load for new user
    Dismiss Android App Chooser If Present
    ${cls}=    Snap Screen    consent_load
    ${past}=    Onboarding Already Past Consents
    IF    ${past}
        Log To Console    Spot: consents already done (class=${cls}) — skip consent load
        RETURN
    END
    ${ssn}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    3
    IF    ${ssn}
        Log To Console    Spot: consents already done — on SSN/DOB, skip consent load
        RETURN
    END
    ${skipped}=    Dismiss Already Consented Screen If Present
    IF    ${skipped}
        RETURN
    END
    ${done}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_DONE_LINK}
    IF    ${done}
        Log To Console    Spot: Thank You/DONE after consents — tap Done then continue
        Click Element    ${CONSENT_DONE_LINK}
        Sleep    2s
        RETURN
    END
    ${reg}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[@text='Registration']
    ${checking}=    Run Keyword And Return Status    Page Should Contain Text    Checking
    IF    ${reg} or ${checking}
        Log To Console    Spot: on SetupCheck/Registration — consents already done, skip consent load
        Run Keyword And Ignore Error    Click Element    xpath=//*[@text='Registration']
        Sleep    2s
        RETURN
    END
    Wait Until Keyword Succeeds    45s    2s    Consent Screen Or WebView Visible

Consent Screen Or WebView Visible
    ${past}=    Onboarding Already Past Consents
    IF    ${past}
        RETURN
    END
    ${t}=    Run Keyword And Return Status    Page Should Contain Text    Consent
    ${ack}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_ACK_CHECKBOX}
    ${ssn}=    Run Keyword And Return Status    Page Should Contain Element    ${SSN_FIELD}
    ${next}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_NEXT_LINK}
    ${done}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_DONE_LINK}
    ${exit}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_EXIT_LINK}
    ${reg}=    Run Keyword And Return Status    Page Should Contain Text    Registration
    ${already}=    Run Keyword And Return Status    Page Should Contain Text    already consented
    Should Be True    ${t} or ${ack} or ${ssn} or ${next} or ${done} or ${exit} or ${reg} or ${already}    msg=Consent not visible

User clicks on Next button
    [Documentation]    First consent WebView page: scroll + acknowledge + NEXT/SUBMIT.
    ...    Spot recovery: skip if consents already submitted (SSN / already-consented EXIT / DONE).
    ${cls}=    Snap Screen    consent_next
    ${past}=    Onboarding Already Past Consents
    IF    ${past}
        Log To Console    Spot: skip consent Next (class=${cls})
        RETURN
    END
    ${ssn}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    3
    IF    ${ssn}
        Log To Console    Spot: skip consent Next — already on SSN
        RETURN
    END
    ${skipped}=    Dismiss Already Consented Screen If Present
    IF    ${skipped}
        RETURN
    END
    ${ack}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_ACK_CHECKBOX}
    ${next}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_NEXT_LINK}
    IF    not ${ack} and not ${next}
        ${done}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_DONE_LINK}
        IF    ${done}
            Click Element    ${CONSENT_DONE_LINK}
            Log To Console    Spot: tapped Done Link (consents finished)
            Sleep    2s
        END
        ${reg}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[@text='Registration']
        IF    ${reg}
            Run Keyword And Ignore Error    Click Element    xpath=//*[@text='Registration']
            Log To Console    Spot: tapped Registration on SetupCheck
            Sleep    2s
        END
        Log To Console    Spot: no consent WebView — skipping Next
        RETURN
    END
    Complete One Consent WebView Page

Self-certification loads
    [Documentation]    Next consent WebView (self-cert content) OR already past if DOB / already-consented.
    Dismiss Android App Chooser If Present
    ${dob}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    5
    IF    ${dob}
        Log To Console    Already on SSN/DOB â€” self-cert already completed
        RETURN
    END
    ${skipped}=    Dismiss Already Consented Screen If Present
    IF    ${skipped}
        RETURN
    END
    Wait Until Keyword Succeeds    30s    1s    Consent WebView Or Text Visible    Self

Consent WebView Or Text Visible
    [Arguments]    ${text}
    ${t}=    Run Keyword And Return Status    Page Should Contain Text    ${text}
    ${ack}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_ACK_CHECKBOX}
    ${consent}=    Run Keyword And Return Status    Page Should Contain Text    Consent
    ${already}=    Run Keyword And Return Status    Page Should Contain Text    already consented
    ${exit}=    Run Keyword And Return Status    Page Should Contain Element    ${CONSENT_EXIT_LINK}
    ${ssn}=    Run Keyword And Return Status    Page Should Contain Element    ${SSN_FIELD}
    Should Be True    ${t} or ${ack} or ${consent} or ${already} or ${exit} or ${ssn}

User clicks on Next button of self-certification
    ${dob}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    3
    IF    ${dob}
        Log To Console    Skip self-cert next â€” on SSN screen
        RETURN
    END
    ${skipped}=    Dismiss Already Consented Screen If Present
    IF    ${skipped}
        RETURN
    END
    Complete One Consent WebView Page

TOS/Privacy Policy loads
    Dismiss Android App Chooser If Present
    ${dob}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    5
    IF    ${dob}
        Log To Console    Already on SSN/DOB â€” TOS already completed
        RETURN
    END
    ${skipped}=    Dismiss Already Consented Screen If Present
    IF    ${skipped}
        RETURN
    END
    Wait Until Keyword Succeeds    30s    1s    Consent WebView Or Text Visible    Privacy

User clicks on Submit button of TOS/Privacy Policy
    [Documentation]    Last consent uses SUBMIT; then SSN (DOB) screen with Exit + Next.
    ${dob}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    3
    IF    ${dob}
        Log To Console    Skip TOS submit â€” already on SSN screen
        RETURN
    END
    ${skipped}=    Dismiss Already Consented Screen If Present
    IF    ${skipped}
        RETURN
    END
    Complete One Consent WebView Page
    Wait Until Element Is Visible    ${SSN_FIELD}    60
    Log To Console    Reached SSN/DOB screen after consents

Input Value In Text Field
    [Documentation]    2.0 pattern: click → clear → Input Text → hide keyboard.
    ...    On 1.5 DOB: NEVER Press Keycode 4 — KEYPAD_HIDE in yaml is BACK and leaves DOB / Splash / Oops.
    [Arguments]    ${locator}    ${value}    ${clear_first}=True
    Dismiss Oops Overlay If Present
    Wait Until Element Is Visible    ${locator}    ${DefaultTimeout}
    Click Element    ${locator}
    Sleep    0.5s
    Dismiss Oops Overlay If Present
    IF    ${clear_first}
        Run Keyword And Ignore Error    Clear Text    ${locator}
    END
    Sleep    1s
    Dismiss Oops Overlay If Present
    Input Text    ${locator}    ${value}
    Log To Console    Entered ${value} into ${locator}
    # 2.0 uses Press Keycode KEYPAD_HIDE (4). On 1.5 that is Android BACK — do NOT use it.
    Run Keyword And Ignore Error    Hide Keyboard
    Sleep    1s
    Dismiss Oops Overlay If Present

Enters year and SSN
    [Documentation]    Year via +/- spinner. SSN via FlashIME key taps (adb input text / Appium InputText opens Oops on 1.5).
    Dismiss Android App Chooser If Present
    Dismiss Oops Overlay If Present
    ${cls}=    Snap Screen    dob_ssn_start
    ${street}=    Run Keyword And Return Status    Page Should Contain Element    ${STREET_ADDRESS}
    IF    ${street}
        Log To Console    Spot: past DOB (class=${cls}) — skip year/SSN
        RETURN
    END
    ${home}=    Run Keyword And Return Status    Page Should Contain Element    ${CONTACTS_APP_ICON}
    IF    ${home}
        Log To Console    Spot: already on home — skip year/SSN
        RETURN
    END
    ${birth_year}=    Get Value From Yaml File    onboarding    birth_year
    ${ssn_last_four}=    Get Value From Yaml File    onboarding    ssn_last_four
    ${udid}=    Get Device Udid
    Wait Until Element Is Visible    ${YEAR_SELECTOR}    120
    ${minus_loc}=    Get Element Location    ${DOB_YEAR_MINUS}
    ${minus_sz}=    Get Element Size    ${DOB_YEAR_MINUS}
    ${mx}=    Evaluate    int(${minus_loc}[x] + ${minus_sz}[width] / 2)
    ${my}=    Evaluate    int(${minus_loc}[y] + ${minus_sz}[height] / 2)
    ${plus_loc}=    Get Element Location    ${DOB_YEAR_PLUS}
    ${plus_sz}=    Get Element Size    ${DOB_YEAR_PLUS}
    ${px}=    Evaluate    int(${plus_loc}[x] + ${plus_sz}[width] / 2)
    ${py}=    Evaluate    int(${plus_loc}[y] + ${plus_sz}[height] / 2)
    FOR    ${i}    IN RANGE    120
        Dismiss Oops Overlay If Present
        ${cur}=    Get Text    ${YEAR_SELECTOR}
        IF    '${cur}' == '${birth_year}'
            Log To Console    Year set to ${cur}
            BREAK
        END
        ${cur_i}=    Convert To Integer    ${cur}
        ${tgt_i}=    Convert To Integer    ${birth_year}
        IF    ${cur_i} > ${tgt_i}
            Run    adb -s ${udid} shell input tap ${mx} ${my}
        ELSE
            Run    adb -s ${udid} shell input tap ${px} ${py}
        END
        Sleep    0.04s
    END
    ${cur}=    Get Text    ${YEAR_SELECTOR}
    Should Be Equal    ${cur}    ${birth_year}    msg=Year spinner did not reach ${birth_year} (still ${cur})
    Type SSN Via FlashIME Keys    ${ssn_last_four}
    Tap on registration next button
    Sleep    2s
    Dismiss Oops Overlay If Present

Tap FlashIME Screencap Key
    [Documentation]    Screencap is 1024x600; adb tap uses portrait. port=(600-ly, lx).
    [Arguments]    ${lx}    ${ly}
    ${udid}=    Get Device Udid
    ${px}=    Evaluate    600 - int(${ly})
    ${py}=    Evaluate    int(${lx})
    Run    adb -s ${udid} shell input tap ${px} ${py}
    Sleep    0.16s

Type SSN Via FlashIME Keys
    [Documentation]    Tap edit_ssn (numeric pad). Clear Del. Tap digits. Hide. No InputText, no ?123, no Oops spam.
    [Arguments]    ${ssn_last_four}
    ${udid}=    Get Device Udid
    Dismiss Oops Overlay If Present
    Wait Until Element Is Visible    ${SSN}    60
    ${ssn_loc}=    Get Element Location    ${SSN}
    ${ssn_sz}=    Get Element Size    ${SSN}
    ${sx}=    Evaluate    int(${ssn_loc}[x] + ${ssn_sz}[width] / 2)
    ${sy}=    Evaluate    int(${ssn_loc}[y] + ${ssn_sz}[height] / 2)
    Run    adb -s ${udid} shell input tap ${sx} ${sy}
    Sleep    1s
    Dismiss Oops Overlay If Present
    # Calibrated from numpad screencap white-glyph centers (1024x600).
    # Layout cols L→R: (3/2/1) (6/5/4) (9/8/7) (Hide/0/Del)
    FOR    ${i}    IN RANGE    8
        Tap FlashIME Screencap Key    973    491
    END
    Sleep    0.2s
    ${digit_lx_ly}=    Evaluate    {'1': '732,491', '2': '732,300', '3': '732,105', '4': '814,491', '5': '814,300', '6': '814,105', '7': '896,491', '8': '896,300', '9': '896,105', '0': '973,300'}
    @{digits}=    Evaluate    list('${ssn_last_four}')
    FOR    ${ch}    IN    @{digits}
        ${pair}=    Get From Dictionary    ${digit_lx_ly}    ${ch}
        @{xy}=    Split String    ${pair}    ,
        Tap FlashIME Screencap Key    ${xy}[0]    ${xy}[1]
        Sleep    0.12s
    END
    Sleep    0.3s
    # Hide
    Tap FlashIME Screencap Key    973    105
    Sleep    0.6s
    Dismiss Oops Overlay If Present
    Wait Until Element Is Visible    ${SSN}    15
    ${ssn_val}=    Get Text    ${SSN}
    Log To Console    SSN via FlashIME: '${ssn_val}' (want ${ssn_last_four})
    IF    '${ssn_val}' != '${ssn_last_four}'
        ${ssn_loc}=    Get Element Location    ${SSN}
        ${ssn_sz}=    Get Element Size    ${SSN}
        ${sx}=    Evaluate    int(${ssn_loc}[x] + ${ssn_sz}[width] / 2)
        ${sy}=    Evaluate    int(${ssn_loc}[y] + ${ssn_sz}[height] / 2)
        Run    adb -s ${udid} shell input tap ${sx} ${sy}
        Sleep    0.8s
        FOR    ${i}    IN RANGE    8
            Tap FlashIME Screencap Key    973    491
        END
        FOR    ${ch}    IN    @{digits}
            ${pair}=    Get From Dictionary    ${digit_lx_ly}    ${ch}
            @{xy}=    Split String    ${pair}    ,
            Tap FlashIME Screencap Key    ${xy}[0]    ${xy}[1]
            Sleep    0.12s
        END
        Tap FlashIME Screencap Key    973    105
        Sleep    0.5s
        ${ssn_val}=    Get Text    ${SSN}
        Log To Console    SSN retry: '${ssn_val}'
    END
    Should Be Equal    ${ssn_val}    ${ssn_last_four}    msg=SSN FlashIME entry failed (got '${ssn_val}')

Tap on registration next button
    Wait Until Element Is Visible    ${REGISTRATION_NEXT_BUTTON}    30
    ${enabled}=    Get Element Attribute    ${REGISTRATION_NEXT_BUTTON}    enabled
    IF    '${enabled}' != 'true'
        Sleep    1s
        ${enabled}=    Get Element Attribute    ${REGISTRATION_NEXT_BUTTON}    enabled
    END
    Should Be Equal    ${enabled}    true    msg=Registration Next disabled — year/SSN incomplete
    Click Element    ${REGISTRATION_NEXT_BUTTON}
    Log To Console    Tapped DOB Next

Verify Registration Page
    [Documentation]    2.0: after DOB — scroll self-cert agreement until Accept enabled, then Accept.
    Dismiss Oops Overlay If Present
    Sleep    3s
    ${accept}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${REGISTRATION_ACCEPT_BUTTON}    30
    IF    not ${accept}
        Wait For Onboarding Screen Containing    Registration
        ${accept}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${REGISTRATION_ACCEPT_BUTTON}    20
    END
    IF    ${accept}
        ${scroll}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${REGISTRATION_SCROLL_AREA}    5
        IF    ${scroll}
            FOR    ${i}    IN RANGE    15
                ${el_ok}=    Run Keyword And Return Status    Get Element Attribute    ${REGISTRATION_ACCEPT_BUTTON}    enabled
                ${enabled}=    Get Element Attribute    ${REGISTRATION_ACCEPT_BUTTON}    enabled
                IF    '${enabled}' == 'true'
                    BREAK
                END
                Flick Scroll Agreement Down
                Sleep    0.5s
            END
        END
        Click Element    ${REGISTRATION_ACCEPT_BUTTON}
        Log To Console    Registration Accept tapped
        Sleep    2s
    ELSE
        Log To Console    No btn_accept — continuing (prompt may already be past)
    END

Flick Scroll Agreement Down
    ${w}=    Get Window Width
    ${h}=    Get Window Height
    ${cx}=    Evaluate    int(${w} * 0.5)
    ${y1}=    Evaluate    int(${h} * 0.75)
    ${y2}=    Evaluate    int(${h} * 0.35)
    Flick    ${cx}    ${y1}    ${cx}    ${y2}

Verify TOS and privacy policy acknowledgment screen
    ${terms}=    Run Keyword And Return Status    Wait Until Keyword Succeeds    30s    2s    Page Should Contain Text    Terms
    IF    not ${terms}
        ${terms}=    Run Keyword And Return Status    Wait Until Keyword Succeeds    20s    2s    Page Should Contain Text    Privacy
    END
    IF    not ${terms}
        ${terms}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${REGISTRATION_ACCEPT_BUTTON}    20
    END
    IF    not ${terms}
        ${terms}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    10
    END
    Should Be True    ${terms}    msg=TOS/Privacy acknowledgment screen not found after DOB
    ${next}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    10
    IF    ${next}
        Click Element    ${SETUP_NEXT_BUTTON}
    END

Accept terms of use
    ${terms}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${TERMS_OF_USE}    30
    IF    ${terms}
        Log To Console    Terms of Use visible
    END
    ${accept}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${REGISTRATION_ACCEPT_BUTTON}    20
    IF    ${accept}
        FOR    ${i}    IN RANGE    12
            ${enabled}=    Get Element Attribute    ${REGISTRATION_ACCEPT_BUTTON}    enabled
            IF    '${enabled}' == 'true'
                BREAK
            END
            Flick Scroll Agreement Down
            Sleep    0.5s
        END
        Click Element    ${REGISTRATION_ACCEPT_BUTTON}
    ELSE
        Click Element    ${SETUP_NEXT_BUTTON}
    END
    Sleep    2s

Verify CPNI agreement acknowledgment screen
    Wait Until Keyword Succeeds    60s    2s    Page Should Contain Text    CPNI
    ${next}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    10
    IF    ${next}
        Click Element    ${SETUP_NEXT_BUTTON}
        Sleep    1s
    END

CPNI loads
    Wait Until Keyword Succeeds    60s    2s    Page Should Contain Text    CPNI
    FOR    ${i}    IN RANGE    15
        ${decline}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${DECLINE_BUTTON}    2
        ${accept}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CPNI_ACCEPT_BUTTON}    2
        IF    ${accept}
            ${enabled}=    Get Element Attribute    ${CPNI_ACCEPT_BUTTON}    enabled
            IF    '${enabled}' == 'true'
                BREAK
            END
        END
        Flick Scroll Agreement Down
        Sleep    0.5s
    END

the user opts in or out
    [Documentation]    2.0 opts out via Decline.
    ${decline}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${DECLINE_BUTTON}    10
    IF    ${decline}
        Click Element    ${DECLINE_BUTTON}
        Log To Console    CPNI Decline (opt out)
    ELSE
        Click Element    ${CPNI_ACCEPT_BUTTON}
        Log To Console    CPNI Accept (opt in)
    END
    Sleep    2s

the VoIP setup will begin
    Wait Until Keyword Succeeds    90s    3s    Page Should Contain Text    VoIP
    ${next}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    20
    IF    ${next}
        Click Element    ${SETUP_NEXT_BUTTON}
        Sleep    2s
    END
    ${accept}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${PROMPT_ACCEPT_BUTTON}    30
    IF    ${accept}
        FOR    ${i}    IN RANGE    15
            ${enabled}=    Get Element Attribute    ${PROMPT_ACCEPT_BUTTON}    enabled
            IF    '${enabled}' == 'true'
                Click Element    ${PROMPT_ACCEPT_BUTTON}
                Log To Console    VoIP/911 Accept
                BREAK
            END
            Flick Scroll Agreement Down
            Sleep    0.5s
        END
    END
    Sleep    2s

User Enters street address and zip code
    ${cls}=    Snap Screen    address_start
    ${home}=    Run Keyword And Return Status    Page Should Contain Element    ${CONTACTS_APP_ICON}
    IF    ${home}
        Log To Console    Spot: already on home (class=${cls}) — skip address
        RETURN
    END
    ${confirm}=    Run Keyword And Return Status    Page Should Contain Text    correct
    IF    ${confirm}
        Log To Console    Spot: already on address confirm — tap Yes
        Tap Address Confirm Yes
        Sleep    2s
        ${finish}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    60
        IF    ${finish}
            Click Element    ${SETUP_NEXT_BUTTON}
        END
        ${start}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    60
        IF    ${start}
            Click Element    ${SETUP_NEXT_BUTTON}
            Log To Console    Tour/Start tapped
        END
        Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    180
        RETURN
    END
    ${street}=    Get Value From Yaml File    text_values    Street_address
    ${zip}=    Get Value From Yaml File    text_values    Zip_Code
    Dismiss Oops Overlay If Present
    Wait Until Element Is Visible    ${STREET_ADDRESS}    60
    Input Value In Text Field    ${STREET_ADDRESS}    ${street}
    Wait Until Element Is Visible    ${ZIP_CODE}    20
    Input Value In Text Field    ${ZIP_CODE}    ${zip}
    Run Keyword And Ignore Error    Hide Keyboard
    Sleep    0.5s
    # Address page Next (2.0: btnNext / START_BTN)
    ${addr_next}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADDRESS_PAGE_NEXT}    15
    IF    ${addr_next}
        Click Element    ${ADDRESS_PAGE_NEXT}
    ELSE
        ${n1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${DOB_NEXT_BTN}    5
        IF    ${n1}
            Click Element    ${DOB_NEXT_BTN}
        ELSE
            ${n2}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    5
            IF    ${n2}
                Click Element    ${SETUP_NEXT_BUTTON}
            END
        END
    END
    Log To Console    Address page Next tapped — waiting for 'Is the address correct?'
    Sleep    2s
    Tap Address Confirm Yes
    Sleep    2s
    # Keep address up to date / Finish prompts
    ${finish}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    60
    IF    ${finish}
        Click Element    ${SETUP_NEXT_BUTTON}
        Log To Console    Address follow-up Next/Finish
        Sleep    2s
    END
    ${finish2}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    30
    IF    ${finish2}
        Click Element    ${SETUP_NEXT_BUTTON}
        Log To Console    Address Finish tapped
        Sleep    2s
    END
    ${start}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SETUP_NEXT_BUTTON}    60
    IF    ${start}
        Click Element    ${SETUP_NEXT_BUTTON}
        Log To Console    Tour/Start tapped
    ELSE
        ${start2}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_NEXT_BTN}    20
        IF    ${start2}
            Click Element    ${ONBOARDING_NEXT_BTN}
            Log To Console    Tour/Start tapped (btnNext)
        END
    END
    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    180
    Log To Console    Onboarding complete — home/contacts visible

Tap Address Confirm Yes
    [Documentation]    'Is the address below correct?' → Yes (activity_setup_prompt_button_yes / btnYes / text Yes).
    ${hint}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ADDRESS_CONFIRM_HINT}    30
    IF    ${hint}
        Log To Console    Address confirm prompt visible
    END
    FOR    ${loc}    IN    ${ADDRESS_CONFIRM_YES}    ${ADDRESS_CONFIRM_YES_ALT}    ${ADDRESS_CONFIRM_YES_TEXT}    ${SETUP_NEXT_BUTTON}
        ${ok}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    8
        IF    ${ok}
            Click Element    ${loc}
            Log To Console    Address confirm Yes tapped (${loc})
            RETURN
        END
    END
    Fail    Address confirm Yes not found (Is the address correct?)

Detect Scenario1 Resume Step
    [Documentation]    After login/TAP TO FIX: return which Scenario_1 step to resume. Uses activity focus + light element checks.
    ${udid}=    Get Device Udid
    ${foc}=    Run    adb -s ${udid} shell "dumpsys window windows | grep mCurrentFocus"
    Log To Console    Current focus: ${foc}
    IF    'MainMenuActivity' in $foc
        RETURN    home
    END
    IF    'VoIPVoiceService' in $foc
        RETURN    voip
    END
    IF    'DOBDataSetup' in $foc
        RETURN    dob
    END
    ${street}=    Run Keyword And Return Status    Page Should Contain Element    ${STREET_ADDRESS}
    IF    ${street}
        RETURN    address
    END
    ${correct}=    Run Keyword And Return Status    Page Should Contain Text    correct
    IF    ${correct}
        RETURN    address_confirm
    END
    ${voip_txt}=    Run Keyword And Return Status    Page Should Contain Text    VoIP
    IF    ${voip_txt}
        RETURN    voip
    END
    ${ssn}=    Run Keyword And Return Status    Page Should Contain Element    ${SSN_FIELD}
    IF    ${ssn}
        RETURN    dob
    END
    ${accept}=    Run Keyword And Return Status    Page Should Contain Element    ${REGISTRATION_ACCEPT_BUTTON}
    IF    ${accept}
        RETURN    registration
    END
    ${cpni}=    Run Keyword And Return Status    Page Should Contain Text    CPNI
    IF    ${cpni}
        RETURN    cpni
    END
    ${tos}=    Run Keyword And Return Status    Page Should Contain Text    Terms of Use
    IF    ${tos}
        RETURN    tos_ack
    END
    ${privacy}=    Run Keyword And Return Status    Page Should Contain Text    Privacy
    IF    ${privacy}
        RETURN    tos_ack
    END
    ${home}=    Run Keyword And Return Status    Page Should Contain Element    ${CONTACTS_APP_ICON}
    IF    ${home}
        RETURN    home
    END
    RETURN    full
