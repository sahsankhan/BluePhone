*** Variables ***

${AMPLIFY_RESET}                 id=clrcap.CCClient:id/csv_boost
${CONSENT_FORM_CLOSE}            id=clrcap.CCClient:id/activity_setup_prompt_button_no
${HANDSET_VOL}                   xpath=(//android.widget.ImageView[@resource-id="clrcap.CCClient:id/ivUp"])[3]
${SETTINGS_OPTIONS_LIST}         xpath=//android.widget.ListView[@resource-id="clrcap.CCClient:id/lvSettings"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart"]
${SETTINGS_APP}                  xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCustom" and @text="SETTINGS"]
${SETTINGS_PHONE}                xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Phone"]
${MY_ACCOUNT}                    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="My Account"]
${NETWORK}                       xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Network"]
${DISPLAY}                       xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Display"]
${VOICEMAIL}                     xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Voicemail"]
${SOUNDS}                        xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Sounds"]
${FLASHER}                       xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Flasher"]
${DATE_AND_TIME}                 xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Date & Time"]
${SETUP_WIZARD}                  xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Setup Wizard"]
${CONSENT_FORM}                  xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Consent Forms"]
${RESET_PHONE}                   xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Reset Phone"]
${SOFTWARE_UPDATE}               xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Software Update"]
${ABOUT}                         xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="About"]

${SETUP_WIZARD_MESSAGE}          xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvMessage"]
${CHECKING_SOFTWARE_UPDATE}      xpath=//android.widget.TextView[@text="Checking software…"]
${CANCEL_BTN}                    id=clrcap.CCClient:id/btnNo
${SOFTWARE_UPDATE_CANCEL}        xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btn_cancel"]

${EMERGENCY_ALERT}               xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Emergency Alerts"]
${WIFI_NETWORKS}                 xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="WiFi Network"]
${WIFI_NAMES}                    id=clrcap.CCClient:id/tv_wifi_name

${TIME}                          id=clrcap.CCClient:id/tvValue
${ONE_MINUTE}                    xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="1 Minute"]
${FIVE_MINUTE}                   xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="5 Minutes"]

${BRIGHTNESS}                    id=clrcap.CCClient:id/sb_brightness
${SETTINGS_APP_MENU}             id=clrcap.CCClient:id/text_view_standart
${EXIT}                          id=clrcap.CCClient:id/btn_no
${HIDDEN_MENU}                   xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Hidden menu"]

${HOME_BTN}                      id=clrcap.CCClient:id/btn_menu

${CAPTION_SETTING}               xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Caption Settings"]
${CAPTION_SETTINGS_TOGGLE}       xpath=//android.widget.TextView[@resource-id='clrcap.CCClient:id/text_view_standart' and @text='Default Settings']/following-sibling::android.view.View[@resource-id='clrcap.CCClient:id/switch_on_off']
${VOIP_MODE_TOGGLE}              id=clrcap.CCClient:id/voip_switch_on_off

${ACTIVE_DIAL_SCREEN}            id=clrcap.CCClient:id/view_call_status_bar_panel_dialing_call
${POST_CALL_REVIEW_TOGGLE}       xpath=//android.widget.TextView[@resource-id='clrcap.CCClient:id/text_view_standart' and @text='Post-call Review']/following-sibling::android.view.View[@resource-id='clrcap.CCClient:id/switch_on_off']

${CLEARCAPTIONS_TEXT}            id=clrcap.CCClient:id/logo
${MENU_CONTENT}                  id=clrcap.CCClient:id/btnMenuContent
${ACCESS_CODE}                   id=clrcap.CCClient:id/access_code
${TESTMODE_TITLE}                id=clrcap.CCClient:id/tv_toolbar_title
${NEXT_BUTTON}                   id=clrcap.CCClient:id/enter
${TESTMODE_VOIP_BTN}             xpath=//android.widget.TextView[@text="VoIP"]
${VOIP_SAVE_BTN}                 id=clrcap.CCClient:id/btn_save_vvm_mode
${ACCEPT_BTN}                    id=clrcap.CCClient:id/activity_setup_prompt_button_yes

${STREET_ADDRESS}                id=clrcap.CCClient:id/address_street
${ZIP_CODE}                      id=clrcap.CCClient:id/address_zip
${SWITCH_BTN}                    id=clrcap.CCClient:id/btn_switch
${TOOLBAR_TITLE}                 id=clrcap.CCClient:id/tv_toolbar_title
${TOOLBAR_BACK_BTN}              id=clrcap.CCClient:id/ib_toolbar_back

${SPEAKER_LEVEL_UP}              xpath=//android.widget.LinearLayout[@resource-id='clrcap.CCClient:id/scv_speakerphone_volume']//android.view.ViewGroup//android.widget.ImageView[@resource-id='clrcap.CCClient:id/ivUp']
${SPEAKERPHONE_VALUE}            xpath=//android.widget.LinearLayout[@resource-id='clrcap.CCClient:id/scv_speakerphone_volume']//android.view.ViewGroup//android.widget.EditText[@resource-id='clrcap.CCClient:id/etValue']

${REMOVE_USER}                   xpath=//android.widget.LinearLayout[.//android.widget.TextView[@text="Remove User"]]//android.widget.ImageView[@resource-id="clrcap.CCClient:id/image_view_standart"]
${REMOVE_USER_PROFILE}           xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="from user profile"]

${OK_BUTTON}                     id=android:id/button3
${REGISTER_BTN}                  id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${ENTER_PASSWORD}                id=clrcap.CCClient:id/et_password
${LOGIN_BTN}                     id=clrcap.CCClient:id/btn_login
${START_BTN}                     id=clrcap.CCClient:id/btnNext
${START_TOUR_BTN}                id=clrcap.CCClient:id/activity_setup_prompt_button_yes
${SOFTWARE_VERSION}              id=clrcap.CCClient:id/tv_software_version

${RESTART_PHONE}                 id=clrcap.CCClient:id/tv_restart_settings
${RESTART_ALERT_MSG}             id=clrcap.CCClient:id/tv_restart_phone_message
${CANCEL_RESTART_BTN}            id=clrcap.CCClient:id/btn_alert_cancel_restart_phone
${RESTART_BTN_FROM_OVERLAY}      id=clrcap.CCClient:id/btn_alert_restart_phone
${RESET_PHONE_TITLE}             id=clrcap.CCClient:id/toolbarView
${FACTORY_SETTINGS}              id=clrcap.CCClient:id/tv_factory_settings
${PERSONAL_SETTINGS}             id=clrcap.CCClient:id/tv_personal_settings
${AUTO_REBOOT_TIME}              id=clrcap.CCClient:id/tv_auto_reboot_settings

${DELETE_ALERT_MSG}              id=clrcap.CCClient:id/tv_alert_delete_title
${SETTINGS_TIME}                 id=clrcap.CCClient:id/time_input
${SETTINGS_DATE}                 id=clrcap.CCClient:id/date_input
${SETTINGS_TIME_HOURS}           id=clrcap.CCClient:id/hours
${SETTINGS_TIME_MINUTES}         id=clrcap.CCClient:id/minutes
${SETTINGS_TIME_AM_PM}           id=clrcap.CCClient:id/am_pm
${SETTINGS_DATE_MONTH}           id=clrcap.CCClient:id/month
${SETTINGS_DATE_DAY}             id=clrcap.CCClient:id/day
${SETTINGS_DATE_YEAR}            id=clrcap.CCClient:id/year
${PHONE_CAPACITY}                xpath=(//android.widget.LinearLayout[@resource-id="clrcap.CCClient:id/ll_list_item"])[1]
${PHONE_CAPACITY_TITLE}          xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tv_toolbar_title"]

${VOICEMAIL_IN_SETTINGS}    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Voicemail"]
${VOICEMAIL_TITLE_SETTINGS}    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tv_toolbar_title" and @text="VOICEMAIL"]

${CLEAR_CAPTIONS_LOGO}          id=clrcap.CCClient:id/logo
${VOIP_MENU}                    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="VoIP"]

${TIME_UP_ARROW}                    id=clrcap.CCClient:id/ivUp
${TIME_DOWN_ARROW}                  id=clrcap.CCClient:id/ivDown
${SOFTWARE_IS_UP_TO_DATE_TEXT}    xpath=//android.widget.TextView[@text="Software is up to date."]
#Sounds settings locators (1.5: labels are plain @text; steppers are LinearLayout scv_*)
${SOUNDS_TITLE}                id=clrcap.CCClient:id/tv_toolbar_title
${RINGTONE_VOLUME}            xpath=//*[@text="Ringtone Volume"]
${RINGTONE_VOLUME_TEXT_FIELD}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_ringer_volume"]//*[@resource-id="clrcap.CCClient:id/etValue"]
${RINGTONE_VOLUME_LEFT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_ringer_volume"]//*[@resource-id="clrcap.CCClient:id/ivDown"]
${RINGTONE_VOLUME_RIGHT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_ringer_volume"]//*[@resource-id="clrcap.CCClient:id/ivUp"]
${RINGTONE_FREQUENCY}            xpath=//*[@text="Ringtone Frequency"]
${RINGTONE_FREQUENCY_LEFT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_ringer_frequency"]//*[@resource-id="clrcap.CCClient:id/ivDown"]
${RINGTONE_FREQUENCY_RIGHT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_ringer_frequency"]//*[@resource-id="clrcap.CCClient:id/ivUp"]
${RINGTONE_FREQUENCY_INPUT_FIELD}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_ringer_frequency"]//*[@resource-id="clrcap.CCClient:id/tvValue"]
${AMPLIFY_RESET_TEXT}                    xpath=//*[@text="Amplify Reset"]
${AMPLIFY_RESET_TOGGLE}       id=clrcap.CCClient:id/csv_boost
${AMPLIFY_TOGGLE_OFF}       xpath=//*[@resource-id="clrcap.CCClient:id/csv_boost" and @content-desc="OFF"]
${AMPLIFY_TOGGLE_ON}       xpath=//*[@resource-id="clrcap.CCClient:id/csv_boost" and @content-desc="ON"]
${HANDSET_VOLUME}            xpath=//*[@text="Handset Volume"]
${HANDSET_VOLUME_LEFT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_handset_volume"]//*[@resource-id="clrcap.CCClient:id/ivDown"]
${HANDSET_VOLUME_RIGHT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_handset_volume"]//*[@resource-id="clrcap.CCClient:id/ivUp"]
${HANDSET_VOLUME_TEXT_FIELD}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_handset_volume"]//*[@resource-id="clrcap.CCClient:id/etValue"]
${HEADSET_VOLUME}            xpath=//*[@text="Headset Volume"]
${HEADSET_VOLUME_LEFT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_headset_volume"]//*[@resource-id="clrcap.CCClient:id/ivDown"]
${HEADSET_VOLUME_RIGHT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_headset_volume"]//*[@resource-id="clrcap.CCClient:id/ivUp"]
${HEADSET_VOLUME_TEXT_FIELD}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_headset_volume"]//*[@resource-id="clrcap.CCClient:id/etValue"]
${SPEAKERPHONE_VOLUME}        xpath=//*[@text="Speakerphone Volume"]
${SPEAKERPHONE_VOLUME_LEFT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_speakerphone_volume"]//*[@resource-id="clrcap.CCClient:id/ivDown"]
${SPEAKERPHONE_VOLUME_RIGHT_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_speakerphone_volume"]//*[@resource-id="clrcap.CCClient:id/ivUp"]
${SPEAKERPHONE_VOLUME_TEXT_FIELD}        xpath=//*[@resource-id="clrcap.CCClient:id/scv_speakerphone_volume"]//*[@resource-id="clrcap.CCClient:id/etValue"]
${NUMERIC_KEYBOARD}           xpath=(//android.widget.FrameLayout[@resource-id="android:id/content"])[2]
${TOUCHSCREEN_SOUND}            xpath=//*[@text="Touchscreen Sounds" or @text="Touchscreen Sound"]
${TOUCHSCREEN_SOUND_TOGGLE}       id=clrcap.CCClient:id/csv_keyboard
${TOUCHSCREEN_SOUND_TOGGLE_OFF}       xpath=//*[@resource-id="clrcap.CCClient:id/csv_keyboard" and @content-desc="OFF"]
${TOUCHSCREEN_SOUND_TOGGLE_ON}       xpath=//*[@resource-id="clrcap.CCClient:id/csv_keyboard" and @content-desc="ON"]
${RINGTONE_FREQUENCY_OPTIONS_CONTAINER}       xpath=/hierarchy/android.widget.FrameLayout
${RINGTONE_FREQUENCY_OPTION_LOW}       xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Low"]
${RINGTONE_FREQUENCY_OPTION_MEDIUM}       xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Med"]
${RINGTONE_FREQUENCY_OPTION_HIGH}       xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="High"]

#Voicemail settings locators
${VOICEMAIL_DESCRIPTION_TEXT}    id=clrcap.CCClient:id/tv_voicemail_description
${GO_TO_VOICEMAIL_BTN}    id=clrcap.CCClient:id/btnCallVoiceMail
${PHONE_PARENT}           xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Phone"]/../..
${VOICEMAIL_PARENT}       xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Voicemail"]/../..
#Display settings locators
${SLEEP_TIMEOUT_TEXT_FIELD}        xpath=//android.view.ViewGroup[@resource-id="clrcap.CCClient:id/scv_sleep_timeout"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue"]
${ONE_MINUTE_SLEEP_TIMEOUT}        xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="1 Minute"]
${TWO_MINUTE_SLEEP_TIMEOUT}        xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="2 Minutes"]
${FIVE_MINUTE_SLEEP_TIMEOUT}       xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="5 Minutes"]
${TEN_MINUTE_SLEEP_TIMEOUT}        xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="10 Minutes"]
${TWENTY_MINUTE_SLEEP_TIMEOUT}     xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="20 Minutes"]
#Date & Time locators
${HAWAII_TIME}              xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Hawaii Time"]
${ALASKA_TIME}              xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Alaska Time"]
${PACIFIC_TIME}             xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Pacific Time"]
${ARIZONA_TIME}             xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Arizona Time"]
${MOUNTAIN_TIME}            xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Mountain Time"]
${CENTRAL_TIME}             xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Central Time"]
${EASTERN_TIME}             xpath=//android.widget.TextView[@resource-id="android:id/text1" and @text="Eastern Time"]
# Date & Time timezone stepper (1.5 uses scv_timezone)
${TIME_ZONE_SELECTOR}       id=clrcap.CCClient:id/lvList
${TIME_ZONE_VALUE}          xpath=//*[@resource-id="clrcap.CCClient:id/scv_timezone"]//*[@resource-id="clrcap.CCClient:id/tvValue"]
${TIME_ZONE_UP_ARROW}       xpath=//*[@resource-id="clrcap.CCClient:id/scv_timezone"]//*[@resource-id="clrcap.CCClient:id/ivUp"]
${TIME_ZONE_DOWN_ARROW}     xpath=//*[@resource-id="clrcap.CCClient:id/scv_timezone"]//*[@resource-id="clrcap.CCClient:id/ivDown"]
${USER_ID}                   id=clrcap.CCClient:id/tv_login

${ERROR_MESSAGE}              id=clrcap.CCClient:id/error_message
${OOPS_MESSAGE}               id=clrcap.CCClient:id/tv_oops
${EXCLAMATION_MARK_IMAGE}     id=clrcap.CCClient:id/alert_image
${TRY_AGAIN_BTN}              id=clrcap.CCClient:id/first_button
${CAPTION_DISPLAY}            xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Caption Display"]

${SPEED_OPTIONS_RIGHT_ARROW}          xpath=(//android.widget.ImageView[@resource-id="clrcap.CCClient:id/ivUp"])[2]
${SPEED_OPTIONS_LEFT_ARROW}          xpath=(//android.widget.ImageView[@resource-id="clrcap.CCClient:id/ivDown"])[2]
${SPEED_OPTION_MEDIUM}                 xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue" and @text="Medium"]
${SPEED_OPTION_SLOW}                   xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue" and @text="Slow"]
${SPEED_OPTION_FAST}                   xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue" and @text="Fast"]

${SPEAKERPHONE_VOLUME_UP}              xpath=(//android.widget.ImageView[@resource-id="clrcap.CCClient:id/ivUp"])[3]
${SPEAKERPHONE_VOLUME_MAX_VALUE}           xpath=//android.widget.EditText[@resource-id="clrcap.CCClient:id/etValue" and @text="12"]
${SPEAKERPHONE_VOLUME_VALUE}           xpath=(//android.widget.EditText[@resource-id="clrcap.CCClient:id/etValue"])[3]
#${NUMERIC_KEYBOARD}       id=com.clrcap.CCKeyboard:id/keyboard

${AUTO_SAVE_CAPTIONS_TOGGLE}       xpath=//android.widget.TextView[@text='Auto-save Captions']/following-sibling::android.view.View[@resource-id='clrcap.CCClient:id/switch_on_off']

${options_menu}                id=clrcap.CCClient:id/text_view_standart
${ADDRESS_OPTION}                       xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Address"]
${ACCOUNT_ADDRESS_OPTION}                       xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/text_view_standart" and @text="Account Address"]
${ACCOUNT_ADDRESS_TITLE}                       id=clrcap.CCClient:id/title_activity_account_address_check
${ADDRESS}                       id=clrcap.CCClient:id/tvAddress
${SHOW_PASSWORD_CHECKBOX}        id=clrcap.CCClient:id/cb_show_password

${SPEED_OPTIONS_IN_CAPTION_DISPLAY}                 xpath=//android.widget.LinearLayout[@resource-id="clrcap.CCClient:id/pace_switcher_container"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue" ]
${RESET_BUTTON_FROM_PERSONAL_SETTINGS_POPUP}             id=clrcap.CCClient:id/btn_alert_reset_personal
${CANCEL_BUTTON_FROM_PERSONAL_SETTINGS_POPUP}             id=clrcap.CCClient:id/btn_alert_cancel_erase
${PERSONAL_SETTINGS_POPUP_MESSAGE}             id=clrcap.CCClient:id/text_alert_message

${INVERT_COLORS}                                xpath=//android.view.ViewGroup[@resource-id="clrcap.CCClient:id/color_switcher"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue"]
${CAPTION_FONT_SIZE_SEEKBAR}                    xpath=//android.widget.SeekBar[@resource-id="clrcap.CCClient:id/font_text_size_seek_bar"]
${SPEED_VALUE_BOX}                              xpath=//android.view.ViewGroup[@resource-id="clrcap.CCClient:id/pace_switcher"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue"]
${PRESENTATION_VALUE}                           xpath=//android.view.ViewGroup[@resource-id="clrcap.CCClient:id/presentation_switcher"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue"]
${MAX_FONT_SIZE}                                id=clrcap.CCClient:id/font_text_size_max
#Phone Capacity
${NOTIFY_LOW_TOGGLE}                            xpath=//android.view.View[@resource-id="clrcap.CCClient:id/csv_notify_me_low"]
${NOTIFY_FULL_TOGGLE}                           xpath=//android.view.View[@resource-id="clrcap.CCClient:id/csv_notify_me_full"]
${AUTO_DELETE_MESSAGES_TOGGLE}                  xpath=//android.view.View[@resource-id="clrcap.CCClient:id/csv_auto_delete_messages"]
${AUTO_DELETE_CALLLOG_TOGGLE}                   xpath=//android.view.View[@resource-id="clrcap.CCClient:id/csv_auto_delete_calllog"]

#Flasher
${INCOMING_CALLS_TOGGLE}                        xpath=//android.view.View[@resource-id="clrcap.CCClient:id/csv_incoming_calls"]
${NEW_MESSAGES_TOGGLE}                          xpath=//android.view.View[@resource-id="clrcap.CCClient:id/csv_new_messages"]
${MISSED_CALLS_TOGGLE}                          xpath=//android.view.View[@resource-id="clrcap.CCClient:id/csv_missed_calls"]

${BRIGHTNESS_SEEKBAR}                           xpath=//android.widget.SeekBar[@resource-id="clrcap.CCClient:id/sb_brightness"]

${VOICEMAIL_FLASH_LIGHT_TOGGLE}                 xpath=//android.widget.TextView[@text="Flash light when I have\nnew messages."]/following-sibling::android.view.View[@resource-id="clrcap.CCClient:id/switch_on_off"]
${SHOW_CALLER_ID_OPTION}                        xpath=//*[contains(@text,'Show Caller ID') or contains(@text,'Caller ID')]

${EMERGENCY_ALERTS_TOGGLE}                      xpath=//android.widget.TextView[@resource-id='clrcap.CCClient:id/text_view_standart' and @text='Emergency Alerts']/following-sibling::android.view.View[@resource-id='clrcap.CCClient:id/switch_on_off']
${SPEED_OPTIONS_BOX}                            id=clrcap.CCClient:id/speedValue
${PRESENTATION_NOTE}                            id=clrcap.CCClient:id/tv_presentation_note

${RINGTONE_SETTINGS_TITLE}    id=clrcap.CCClient:id/ringer_volume_title
${AMPLIFY_SETTINGS_TITLE}    id=clrcap.CCClient:id/amplify_settings_title
${SYSTEM_SOUNDS_TITLE}    id=clrcap.CCClient:id/touchscreen_sounds_title
${RINGTONE_FREQUENCY_STEPPER}    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvValue"]

${SOFTWARE_UPDATE_CHECK_TEXT}    xpath=//android.widget.TextView[@text="Checking software…"]
${SOFTWARE_UPDATE_LOADER}    xpath=//android.widget.ImageView[@resource-id="clrcap.CCClient:id/cp_progress"]
${SOFTWARE_IS_UPTO_DATE}    xpath=//android.widget.TextView[@text="Software is up to date."]
${PRESENTATION_OPTIONS_RIGHT_ARROW}            xpath=//android.view.ViewGroup[@resource-id="clrcap.CCClient:id/presentation_switcher"]//android.widget.ImageView[@resource-id="clrcap.CCClient:id/ivUp"]
${PRESENTATION_LINE_ITEM}            xpath=//android.widget.LinearLayout[@resource-id="clrcap.CCClient:id/presentation_switcher_container"]//android.widget.TextView[@text="Presentation"]
${PRESENTATION_OPTIONS_LEFT_ARROW}             xpath=//android.view.ViewGroup[@resource-id="clrcap.CCClient:id/presentation_switcher"]//android.widget.ImageView[@resource-id="clrcap.CCClient:id/ivDown"]