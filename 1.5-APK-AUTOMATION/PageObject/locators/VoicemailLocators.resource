*** Variables ***
${VOICEMAIL_BADGE_COUNTER}        xpath=//android.widget.RelativeLayout[@resource-id="clrcap.CCClient:id/viewVoiceMail"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCount"]
${VOICEMAIL_HOME_TILE}            id=clrcap.CCClient:id/viewVoiceMail
${VOICEMAIL_APP}                  xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCustom" and (translate(@text,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')='VOICEMAIL')]
${FIRST_RECENT_VOICEMAIL}         id=clrcap.CCClient:id/rootAudioRecordItem
${DIAL_ICON}                      xpath=//android.widget.LinearLayout[@resource-id="clrcap.CCClient:id/topPanel"]/android.widget.LinearLayout/android.widget.ImageView
${VM_LOADING_SPINNER}             id=clrcap.CCClient:id/audioRecordsProgress
${VM_DELETE_PROGRESS}             id=clrcap.CCClient:id/rotationProgressDetails
${VM_HOME_BUTTON}                 id=clrcap.CCClient:id/btn_menu
${VM_BACK_BUTTON}                 id=clrcap.CCClient:id/ib_toolbar_back
${VOICEMAIL_CONTINUE_BUTTON}      id=clrcap.CCClient:id/btn_continue
${VM_DID_NUMBER}                  xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/callerNameAudioRecordItem"])[1]
${VM_EDIT_BUTTON}                 id=clrcap.CCClient:id/btn_edit
${VM_DELETE_ALL_BUTTON}           id=clrcap.CCClient:id/btn_delete
${VM_DELETE_YES_ALERT_BTN}        id=clrcap.CCClient:id/btn_alert_yes
${VM_DELETE_NO_ALERT_BTN}         id=clrcap.CCClient:id/btn_alert_no
${VM_DELETE_ACCEPT_BTN}           xpath=//android.widget.Button[contains(@text,'ACCEPT')]
${VM_PERMANENT_DELETE_MESSAGE}    id=clrcap.CCClient:id/tv_alert_delete_title
${VM_DELETE_FIRST_CONFIRM_MSG}    id=clrcap.CCClient:id/tvMessage
${NO_MESSAGES}                    id=clrcap.CCClient:id/audioRecordsEmpty
${NO_VM_MESSAGES_TEXT}            xpath=//android.widget.TextView[contains(@text,'You have no messages')]
${VM_PLAY_BTN_CENTER}             id=clrcap.CCClient:id/center_play
