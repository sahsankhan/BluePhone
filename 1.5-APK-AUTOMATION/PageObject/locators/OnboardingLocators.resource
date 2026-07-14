*** Variables ***
${ONBOARDING_NEXT_BTN}            id=clrcap.CCClient:id/btnNext
${ONBOARDING_SUBMIT_BTN}         id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${ONBOARDING_DECLINE_BTN}        id=clrcap.CCClient:id/activity_setup_prompt_button_no
${ONBOARDING_TOOLBAR_TITLE}      id=clrcap.CCClient:id/tv_toolbar_title
${ONBOARDING_ENTER_BTN}          id=clrcap.CCClient:id/enter
${BIRTH_YEAR_FIELD}              xpath=//android.widget.EditText[contains(@resource-id,'year') or contains(translate(@content-desc,'YEAR','year'),'year')]
${SSN_FIELD}                     xpath=//android.widget.EditText[contains(@resource-id,'ssn') or contains(translate(@content-desc,'SSN','ssn'),'ssn')]
${ONBOARDING_CHECKBOX}           xpath=//android.widget.CheckBox
