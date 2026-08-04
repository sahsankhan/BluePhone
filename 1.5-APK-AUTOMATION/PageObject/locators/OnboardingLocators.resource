*** Variables ***
# Welcome / setup
${ONBOARDING_NEXT_BTN}            id=clrcap.CCClient:id/btnNext
${ONBOARDING_BTN_NEXT}            id=clrcap.CCClient:id/btn_next
${ONBOARDING_SUBMIT_BTN}         id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${ONBOARDING_DECLINE_BTN}        id=clrcap.CCClient:id/activity_setup_prompt_button_no
${ONBOARDING_TOOLBAR_TITLE}      id=clrcap.CCClient:id/tv_toolbar_title
${ONBOARDING_ENTER_BTN}          id=clrcap.CCClient:id/enter
${ONBOARDING_EXIT_BTN}           id=clrcap.CCClient:id/btn_exit

# Login
${TAP_TO_FIX_NOW}                id=clrcap.CCClient:id/alert_label_text_view
${CONNECTION_PROBLEM_BANNER}     id=clrcap.CCClient:id/btnConnectionProblem
${USERNAME_INPUT}                id=clrcap.CCClient:id/et_email

# Consent WebView — 1.5 uses WebView links; also match 2.0 content-desc=NEXT / text NEXT
${CONSENT_ACK_CHECKBOX}          xpath=//*[@class='android.widget.CheckBox' and contains(@content-desc,'acknowledge')]
${CONSENT_ACK_CHECKBOX_FALLBACK}    class=android.widget.CheckBox
${CONSENT_NEXT_LINK}             accessibility_id=NEXT Link
${CONSENT_NEXT_LINK_2}           accessibility_id=NEXT
${CONSENT_NEXT_TEXT}             xpath=//*[@text='NEXT' or @content-desc='NEXT' or @content-desc='NEXT Link']
${CONSENT_SUBMIT_LINK}           accessibility_id=SUBMIT Link
${CONSENT_SUBMIT_LINK_2}         accessibility_id=SUBMIT
${CONSENT_SUBMIT_TEXT}           xpath=//*[@text='SUBMIT' or @content-desc='SUBMIT' or @content-desc='SUBMIT Link']
${CONSENT_EXIT_LINK}             accessibility_id=EXIT Link
${CONSENT_DONE_LINK}             accessibility_id=Done Link
${CONSENT_SCROLL_HERE}           accessibility_id=SCROLL HERE
${CONSENT_ACK_LABEL}             xpath=//*[contains(@text,'acknowledge') or contains(@content-desc,'acknowledge') or contains(@text,'I have read')]

# DOB / SSN (DOBDataSetupActivity) — discovered on device
${DOB_MONTH_FIELD}               id=clrcap.CCClient:id/month_display
${DOB_DATE_FIELD}                id=clrcap.CCClient:id/date_display
${DOB_YEAR_FIELD}                id=clrcap.CCClient:id/year_display
${DOB_YEAR_PLUS}                 id=clrcap.CCClient:id/year_plus
${DOB_YEAR_MINUS}                id=clrcap.CCClient:id/year_minus
${BIRTH_YEAR_FIELD}              id=clrcap.CCClient:id/year_display
${YEAR_SELECTOR}                 id=clrcap.CCClient:id/year_display
${SSN_FIELD}                     id=clrcap.CCClient:id/edit_ssn
${SSN}                           id=clrcap.CCClient:id/edit_ssn
${DOB_NEXT_BTN}                  id=clrcap.CCClient:id/btn_next
${REGISTRATION_NEXT_BUTTON}      id=clrcap.CCClient:id/btn_next
${DOB_EXIT_BTN}                  id=clrcap.CCClient:id/btn_exit
${DOB_CHECKBOX}                  id=clrcap.CCClient:id/btn_checkbox
${ONBOARDING_CHECKBOX}           class=android.widget.CheckBox

# Post-DOB registration / agreements (from 2.0 CommonLocators)
${REGISTRATION_ACCEPT_BUTTON}    id=clrcap.CCClient:id/btn_accept
${REGISTRATION_SCROLL_AREA}      id=clrcap.CCClient:id/svAgreement
${REGISTRATION_TEXT}             id=clrcap.CCClient:id/activity_setup_prompt_text_label
${SETUP_PROMPT_TEXT}             id=clrcap.CCClient:id/activity_setup_prompt_text_message
${SETUP_NEXT_BUTTON}             id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${DECLINE_BUTTON}                id=clrcap.CCClient:id/activity_setup_prompt_button_no
${TERMS_OF_USE}                  xpath=//*[@text='Terms of Use' or contains(@text,'Terms')]
${CPNI_SCROLL_AREA}              id=clrcap.CCClient:id/agreement_scroll_view
${CPNI_ACCEPT_BUTTON}            id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${PROMPT_SCROLL_AREA}            id=clrcap.CCClient:id/agreement_scroll_view
${PROMPT_ACCEPT_BUTTON}          id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${ZIP_CODE}                      id=clrcap.CCClient:id/address_zip
${STREET_ADDRESS}                id=clrcap.CCClient:id/address_street
${ADDRESS_PAGE_NEXT}             id=clrcap.CCClient:id/btnNext
${ADDRESS_CONFIRM_YES}           id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${ADDRESS_CONFIRM_YES_ALT}       id=clrcap.CCClient:id/btnYes
${ADDRESS_CONFIRM_YES_TEXT}      xpath=//*[@text='Yes' or @text='YES' or contains(@content-desc,'Yes') or contains(@content-desc,'YES')]
${ADDRESS_CONFIRM_HINT}          xpath=//*[contains(@text,'correct') or contains(@text,'address below') or contains(@text,'Is the address')]

${SETUP_CHECK_ACTIVITY_HINT}     xpath=//*[contains(@text,'Checking') or contains(@text,'Network')]
