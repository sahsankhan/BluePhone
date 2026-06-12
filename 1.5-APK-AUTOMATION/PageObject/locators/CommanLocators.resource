*** Variables ***
${My_Number}    id=clrcap.CCClient:id/voipNumberMain
${Contacts_button}    id=clrcap.CCClient:id/btnContacts
${Contacts_title}    id=clrcap.CCClient:id/tv_toolbar_title
${Search_Box}    id=clrcap.CCClient:id/et_search
${Contact_Name}    id=clrcap.CCClient:id/textViewFullname
${Contact_Number}    id=clrcap.CCClient:id/textViewPhoneNumber

${Contact_Add_Button}    id=clrcap.CCClient:id/btn_add_contact
${Contact_Firstname}    id=clrcap.CCClient:id/et_first_name
${Contact_Lastname}    id=clrcap.CCClient:id/et_last_name
${Contact_Phone_Number}    id=clrcap.CCClient:id/et_phone
${Contact_Phone_Number_Dhaval}    id=clrcap.CCClient:id/phoneNumberItem

${Contact_Full_Name}    id=clrcap.CCClient:id/tv_full_name
${Home_button}    id=clrcap.CCClient:id/btn_menu

${Searched_contact_full_name}    id=clrcap.CCClient:id/textViewFullname
${Favorite_icon}    id=clrcap.CCClient:id/btnFavorites
${Add_fav_confirmation_message}    id=clrcap.CCClient:id/tvMessage

${fav_icon_on_contact}    id=clrcap.CCClient:id/iv_contact_favorite

${Comtact_phone_number}    id=clrcap.CCClient:id/textViewPhoneNumber

${Captions_screen}    id=clrcap.CCClient:id/caption_invisible_reflection
${Captions_text}    id=clrcap.CCClient:id/optionsText

${post_call_screen_options_button}    id=clrcap.CCClient:id/optionsText
${post_call_screen_home_button}    id=clrcap.CCClient:id/btn_menu

${post_call_screen_contact_name}    id=clrcap.CCClient:id/tv_name
${post_call_screen_call_duration}    id=clrcap.CCClient:id/tv_time

${call_log_button}    id=clrcap.CCClient:id/btnCallLogs
${Recent_call_log_name}    xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewDisplay"])[1]
${Recent_call_log_duration}    xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvTimer"])[1]

# =======================
# Home Screen Locators
# =======================

${MAIN_MENU_TITLE}              id=clrcap.CCClient:id/tvMenuTitle
${DEVICE_NUMBER}                id=clrcap.CCClient:id/voipNumberMain
${TITLE}                        id=clrcap.CCClient:id/toolbar
${HOME_DURING_CALL}             id=clrcap.CCClient:id/btnMenuLayout
${CALL_DURATION}                id=clrcap.CCClient:id/view_call_status_bar_panel_current_call_text_call_duration

${WIFI_INDICATOR}               id=clrcap.CCClient:id/ivWifi
${AMPLIFIED_RINGER_INDICATOR}   id=clrcap.CCClient:id/ivRinger
${MUTED_RINGER_INDICATOR}       id=clrcap.CCClient:id/ivRinger

# =======================
# Common YES / NO Buttons
# =======================

${YES_BTN}                      xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btnYes"]
${NO_BTN}                       xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btnNo"]

# =======================
# Ongoing Call Screen
# =======================

${OPTIONS}                      id=clrcap.CCClient:id/optionsText
${ADD_BTN}                      id=clrcap.CCClient:id/btn_add
${MERGE_BTN}                    id=clrcap.CCClient:id/btn_merge

${VOIP_MERGED_TEXT}             xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/view_call_status_bar_panel_current_call_text_caller_name"]
${PSTN_MERGE_TEXT}              id=clrcap.CCClient:id/view_call_status_bar_panel_other_call_image_merge_call
${CALL_NOW_BTN}                 id=clrcap.CCClient:id/btn_alert_call

# ${CLOSE_BTN}                    xpath=//android.widget.TextView[@text="CLOSE"]
${CLOSE_BTN}                    id=clrcap.CCClient:id/fl_close
${IGNORE_BTN}                   id=clrcap.CCClient:id/btnIgnoreCall

${CAPTION_BTN}                  id=clrcap.CCClient:id/incCaptionRoot
${CAPTION_BTN_DIAL}             id=clrcap.CCClient:id/btnTurnCaptionsOn
${CAPTION_BTN_INCOMING}         id=clrcap.CCClient:id/btn_turn_captions_on

# =======================
# Headers & Call Status
# =======================

${GREEN_HEADER}                 xpath=//android.view.ViewGroup[@content-desc="Blue To Green"]
${BLUE_HEADER}                  xpath=//android.view.ViewGroup[@content-desc="Green To Blue"]
${GREEN_HEADER_TEST}            xpath=//android.widget.LinearLayout[@content-desc="Blue To Green"]
${BUSY_SIGNAL}                  xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tv_caption" and @text="[ Busy Signal ]"]
${POST_CALL_DURATION}           id=clrcap.CCClient:id/tv_time

# =======================
# Call Actions
# =======================

${ANSWER_BUTTON}                id=clrcap.CCClient:id/view_call_status_bar_panel_incoming_call_button_answer
${OPTIONS_BUTTON}               id=clrcap.CCClient:id/optionsText
${END_CALL}                     xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/view_call_status_bar_panel_current_call_button_action"]

${EVENT_TITLE_CAPTIONS}         id=clrcap.CCClient:id/event_title

# =======================
# Caption & Font
# =======================

${FONT_BTN}                     id=clrcap.CCClient:id/btn_font
${FONT_SCROLL_BAR}              id=clrcap.CCClient:id/font_text_size_seek_bar
${RESUME_BUTTON}                id=clrcap.CCClient:id/view_call_status_bar_panel_current_call_button_action

${HOME_BTN}                     id=clrcap.CCClient:id/btn_menu
${CAPTION_NOT_ENABLED}          id=clrcap.CCClient:id/captions_not_enabled
${TAP_TO_FIX_NOW}               xpath=//android.widget.TextView[@text="TAP TO FIX NOW"]

${CAPTION_ID}                   id=clrcap.CCClient:id/tv_caption
${PSTN_FIRST_CALL_DURATION}     id=clrcap.CCClient:id/view_call_status_bar_panel_other_call_text_call_duration

# =======================
# Predial Screen
# =======================

${PREDIAL_NUMBER}               id=clrcap.CCClient:id/tvPhoneNumber
${PREDIAL_CONTACT_AVATAR}       id=clrcap.CCClient:id/txt_avatar_letter

# =======================
# Incoming Call Screen
# =======================

${INSTRUCTION_MESSAGE_CALL}     id=clrcap.CCClient:id/tvCallHint
${CONTACT_NAME}                 id=clrcap.CCClient:id/tvName
${CONTACT_NUMBER}               id=clrcap.CCClient:id/tvPhoneNumber

# =======================
# Home Screen Header
# =======================

${CURRENT_TIME}                 id=clrcap.CCClient:id/tvTimer
${CC_LOGO}                      id=clrcap.CCClient:id/ivVoiceService

# =======================
# Contact Screen
# =======================

${CONTACTS_HOME}                xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCustom" and @text="CONTACTS"]
${ADD_CONTACT_BUTTON}           id=clrcap.CCClient:id/btn_add_contact
${FIRST_NAME_FIELD}             id=clrcap.CCClient:id/et_first_name
${LAST_NAME_FIELD}              id=clrcap.CCClient:id/et_last_name
${PHONE_NUMBER_FIELD}           id=clrcap.CCClient:id/et_phone
${PHONE_NUMBER_FIELD_COUNT}     xpath=//android.widget.EditText[@resource-id="clrcap.CCClient:id/et_phone"]

# =======================
# Caption Alerts & Sleep
# =======================

${CAPTION_BTN_ALERT_MSG}        id=clrcap.CCClient:id/tvMessage
${SLEEP_BAR}                    id=clrcap.CCClient:id/iv_bottom_slide_bar

${CAPTIONER_CONTAINER}          id=clrcap.CCClient:id/tv_caption
${SAVED_PHONE_NUMBER_LIST}      xpath=//android.widget.ListView[@resource-id="clrcap.CCClient:id/lv_phones"]
${SAVE_DELETE_BTN}              id=clrcap.CCClient:id/btn_extra_action
${CAPTION_DATE_TIME_TEXT}       xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/tv_caption'])[4]

${BLACK_SCREEN}                 id=android:id/content

${ADD_BUTTON_IN_OPTIONS_MENU}           id=clrcap.CCClient:id/btn_add

${SPEED_MENU}                      id=clrcap.CCClient:id/speedValue
${SPEED_INCREASE_BUTTON}           id=clrcap.CCClient:id/increaseSpeedButton
${SPEED_DECREASE_BUTTON}           id=clrcap.CCClient:id/decreaseSpeedButton

${SAVE_CAPTIONS_BUTTON}              id=clrcap.CCClient:id/btn_save

${CALL_WAITING_BANNER}            id=clrcap.CCClient:id/view_call_status_bar_panel_incoming_call_text_name
${GREEN_CHEVRON_MARKER}           id=clrcap.CCClient:id/ib_to_bottom