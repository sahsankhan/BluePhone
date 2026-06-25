*** Variables ***

#Caption Settings
${POST_CALL_REVIEW_ON}    XPath=(//android.view.View[@content-desc="ON"])[1]
${POST_CALL_REVIEW_OFF}    XPath=(//android.view.View[@content-desc="OFF"])[1]
${SETTINGS_APP}                  id=clrcap.CCClient:id/btnSettings
${RESET_PHONE}                   xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Reset Phone"]
${RESTART_PHONE}                 xpath=//android.widget.TextView[@text="Restart Phone"]
${RESTART_ALERT_MSG}             xpath=//android.widget.LinearLayout[@resource-id="clrcap.CCClient:id/alert_restart_phone"]/android.widget.TextView
${CANCEL_RESTART_BTN}            xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btn_alert_cancel_restart_phone"]
${RESET_PHONE_TITLE}             xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tv_toolbar_title"]
${ABOUT}                   xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="About"]
${PHONE}                   xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Phone"]
${SETTINGS_APP_TEXT}       xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCustom" and @text="Settings"]
${SETTINGS_DISPLAY}        xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Display"]
${SETTINGS_HIDDEN_MENU}    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Hidden menu"]
${SETTINGS_SLEEP_TIMEOUT}  xpath=//android.view.ViewGroup[@resource-id="clrcap.CCClient:id/scv_sleep_timeout"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue"]
${SETTINGS_SLEEP_1_MIN}    xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="1 Minute"]
${SETTINGS_SLEEP_20_MIN}   xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="20 Minutes"]
${SETTINGS_HOME_BTN}       id=clrcap.CCClient:id/btn_menu