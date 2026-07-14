*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
Click Onboarding Next Button
    ${next_by_id}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_NEXT_BTN}    5
    Run Keyword If    ${next_by_id}    Click Element    ${ONBOARDING_NEXT_BTN}
    ...    ELSE    Run Keywords
    ...    Wait Until Element Is Visible    ${ONBOARDING_ENTER_BTN}    ${DefaultTimeout}
    ...    AND    Click Element    ${ONBOARDING_ENTER_BTN}

Click Onboarding Submit Button
    ${submit_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_SUBMIT_BTN}    5
    Run Keyword If    ${submit_visible}    Click Element    ${ONBOARDING_SUBMIT_BTN}
    ...    ELSE    Click Onboarding Next Button

Wait For Onboarding Screen Containing
    [Arguments]    ${text}
    Wait Until Keyword Succeeds    120s    2s    Page Should Contain Text    ${text}

new user can login
    ${login_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_BTN}    60
    IF    not ${login_visible}
        Fail    New user login screen not displayed. Use a fresh/unprovisioned device or reset before running TMCC-11547.
    END
    Wait Until Element Is Visible    ${USER_ID}    ${DefaultTimeout}
    Input Text    ${ENTER_PASSWORD}    ${ACCOUNT_PASSWORD}
    Click Element    ${LOGIN_BTN}
    Sleep    3s    Allow login transition to onboarding screens

Consent forms load for new user
    Wait For Onboarding Screen Containing    Consent

User clicks on Next button
    Click Onboarding Next Button

Self-certification loads
    Wait For Onboarding Screen Containing    Self

User clicks on Next button of self-certification
    Click Onboarding Next Button

TOS/Privacy Policy loads
    Wait For Onboarding Screen Containing    Privacy

User clicks on Submit button of TOS/Privacy Policy
    Click Onboarding Submit Button

Enters year and SSN
    ${birth_year}=    Get Value From Yaml File    onboarding    birth_year
    ${ssn_last_four}=    Get Value From Yaml File    onboarding    ssn_last_four
    ${year_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${BIRTH_YEAR_FIELD}    10
    Run Keyword If    ${year_visible}    Input Text    ${BIRTH_YEAR_FIELD}    ${birth_year}
    ${ssn_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${SSN_FIELD}    10
    Run Keyword If    ${ssn_visible}    Input Text    ${SSN_FIELD}    ${ssn_last_four}

Verify Registration Page
    Wait For Onboarding Screen Containing    Registration

Verify TOS and privacy policy acknowledgment screen
    Wait For Onboarding Screen Containing    Terms

Accept terms of use
    Click Onboarding Submit Button

Verify CPNI agreement acknowledgment screen
    Wait For Onboarding Screen Containing    CPNI

CPNI loads
    Wait For Onboarding Screen Containing    CPNI

the user opts in or out
    ${accept_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ONBOARDING_SUBMIT_BTN}    5
    Run Keyword If    ${accept_visible}    Click Element    ${ONBOARDING_SUBMIT_BTN}
    ...    ELSE    Click Onboarding Next Button

the VoIP setup will begin
    Wait For Onboarding Screen Containing    VoIP

User Enters street address and zip code
    ${street}=    Get Value From Yaml File    text_values    Street_address
    ${zip}=    Get Value From Yaml File    text_values    Zip_Code
    Wait Until Element Is Visible    ${STREET_ADDRESS}    ${DefaultTimeout}
    Input Text    ${STREET_ADDRESS}    ${street}
    Input Text    ${ZIP_CODE}    ${zip}
    Click Onboarding Submit Button
    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    180
