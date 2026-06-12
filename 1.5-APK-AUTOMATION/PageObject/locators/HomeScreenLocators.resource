*** Variables ***
${MY_NUMBER}    id=clrcap.CCClient:id/voipNumberMain
${HOME_BUTTON}    id=clrcap.CCClient:id/btn_menu
${CC_ICON}    id=clrcap.CCClient:id/ivVoiceService
${DIALLED_NUMBER_TEXT}    ID=clrcap.CCClient:id/tvPhoneNumber
${DIAL_A_NUMBER_ICON}    ID=clrcap.CCClient:id/iv_toolbar_icon
${DIAL_A_NUMBER_TEXT}    ID=clrcap.CCClient:id/tv_toolbar_title
${CONTACTS_APP_TEXT}    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCustom" and @text="Contacts"]
${CONTACTS_APP_ICON}    xpath=(//android.widget.ImageView[@resource-id="clrcap.CCClient:id/imageViewCustom"])[1]
${CALL_LOG_TEXT}    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCustom" and @text="Call log"]
${CALL_LOG_ICON}    xpath=(//android.widget.ImageView[@resource-id="clrcap.CCClient:id/imageViewCustom"])[3]