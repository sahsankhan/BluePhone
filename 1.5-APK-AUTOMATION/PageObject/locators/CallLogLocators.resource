*** Variables ***
${CALL_LOG_APP}                         xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCustom" and @text="CALL LOG"]
${CALL_LOG_TITLE}                       id=clrcap.CCClient:id/tv_toolbar_title
${BACK_BTN_ON_CALL_LOG}                 id=clrcap.CCClient:id/ib_toolbar_back
${CANCEL_BUTTON}                        id=clrcap.CCClient:id/ib_toolbar_cancel
${CALL_COUNT}                           id=clrcap.CCClient:id/count
${CALL_LOG_ICON}                        id=clrcap.CCClient:id/iv_toolbar_icon
${CC_ICON}                              id=clrcap.CCClient:id/imageViewIcon
${CALL_LOG_NAME}                        id=clrcap.CCClient:id/tv_contact_name
${CALL_LOG_DATE_AND_DURATION}           id=clrcap.CCClient:id/tv_caption_date
${CC_ICON_ON_FIRST_ROW}                 xpath=(//android.widget.ImageView[@content-desc="CaptionedCall"])[1]
${CC_ICON_ON_SECOND_ROW}                xpath=(//android.widget.ImageView[@content-desc="CaptionedCall"])[2]

${ALL_CALLS}                            id=clrcap.CCClient:id/textViewDisplay
${MISSED_CALL_TAB}                      id=clrcap.CCClient:id/rb_missed_small
${CALL_TYPES}                           xpath=(//android.widget.ImageView[@content-desc="MissedCallRead"])[1]
${MISSED_CALL_TIME}                     id=clrcap.CCClient:id/tvTimer
${MISSED_CALL_ARROW}                   id=clrcap.CCClient:id/arrow_image
${MISSED_CONTACT}                      id=clrcap.CCClient:id/tv_contact_name
${MISSED_AVTAR}                        id=clrcap.CCClient:id/iv_avatar
${CALL_BACK_BTN}                       id=clrcap.CCClient:id/iv_callback
${TIME_DATE_OF_MISSED_CALL}             id=clrcap.CCClient:id/tv_caption_date

${RADIO_ALL_CALLS}                      id=clrcap.CCClient:id/rb_all_small
${RADIO_MISSED_CALLS}                  id=clrcap.CCClient:id/rb_missed_small
${CALL_LOG_CAPTIONED_TAB}              id=clrcap.CCClient:id/rb_captioned_small

${NEXT_ARROW}                          id=clrcap.CCClient:id/arrow_image
${CALL_RECORD_DETAIL}                  id=clrcap.CCClient:id/ll_info_panel

${CAPTIONER_DURING_CALL}               id=clrcap.CCClient:id/tv_caption

${HOME_BUTTON}                         id=clrcap.CCClient:id/mBottomMenu
${SEARCH_ICON}                         id=clrcap.CCClient:id/btn_search
${EDIT_BUTTON}                         id=clrcap.CCClient:id/btn_edit
${SEARCH_INPUT_FIELD}                  id=clrcap.CCClient:id/et_search
${DONE_BUTTON}                         id=clrcap.CCClient:id/btn_done
${DELETE_ALL_BUTTON}                   id=clrcap.CCClient:id/btn_delete
${OPTION_BUTTON}                       id=clrcap.CCClient:id/optionsText
${FONT_BUTTON}                         id=clrcap.CCClient:id/btn_font
${CAPTION_DELETE}                      id=clrcap.CCClient:id/btn_extra_action
${HOME_BUTTON_ON_DIALED_SCREEN}        id=clrcap.CCClient:id/btnMenuLayout
${EDIT_MODE}                           id=clrcap.CCClient:id/tv_toolbar_title
${FIRST_CALL_NUMBER}                   id=clrcap.CCClient:id/textViewDisplay
${FIRST_CALL_TIME}                     id=clrcap.CCClient:id/tvTimer
${DELETE_ICON}                         xpath=(//android.widget.ImageView[@content-desc="DeleteItem"])[1]

${CALL_LOG_LIST}                       id=clrcap.CCClient:id/lvList
${CALL_LOG_ITEM}                       id=clrcap.CCClient:id/cal_log_det_click_area
${DELETE_CALL_BUTTON}                  id=clrcap.CCClient:id/image_delete
${INDIVIDUAL_DELETE_CALL}              xpath=(//android.widget.ImageView[@content-desc="DeleteItem"])[1]

${CALL_TYPE_IMAGE}                     id=clrcap.CCClient:id/ivCallType
${CALL_DISPLAY_TEXT}                   id=clrcap.CCClient:id/textViewDisplay
${CALL_TIME_TEXT}                      id=clrcap.CCClient:id/tvTimer
${CALL_DURATION_TEXT}                  id=clrcap.CCClient:id/tv_duration
${CALL_DAY_TEXT}                       id=clrcap.CCClient:id/text_header

${DELETE_ALERT_MSG}                    id=clrcap.CCClient:id/tv_alert_delete_title
${YES_BUTTON}                          id=clrcap.CCClient:id/btn_alert_yes
${NO_BUTTON}                           id=clrcap.CCClient:id/btn_alert_no
${CAPTION_ALERT_YES_BTN}               xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btnYes"]

${MISSED_CALL}                         id=clrcap.CCClient:id/rb_missed_small
${ARROW_BUTTON}                        xpath=(//android.widget.ImageView[@resource-id="clrcap.CCClient:id/arrow_image"])[1]
${MISSED_CALL_TITLE_TOOLBAR}            id=clrcap.CCClient:id/tv_toolbar_title
${MISSED_CALL_DATE_AND_TIME}            id=clrcap.CCClient:id/tv_caption_date
${CALL_BACK_BUTTON}                    id=clrcap.CCClient:id/iv_callback
${HOME_BUTTON_ON_MISSED_CALL}           id=clrcap.CCClient:id/btnMenuLayout
${CONTACT_NUMBER_OR_NAME}               id=clrcap.CCClient:id/tv_contact_name
${AVTAR_ON_MISSED_CALL}                 id=clrcap.CCClient:id/iv_avatar
${ADD_BUTTON}                           id=clrcap.CCClient:id/btn_add

${FIRST_NAME}                           id=clrcap.CCClient:id/et_first_name
${LAST_NAME}                            id=clrcap.CCClient:id/et_last_name
${ADD_NUMBER_WITH_ICON}                 id=clrcap.CCClient:id/btn_add_field
${PHONE}                                id=clrcap.CCClient:id/et_phone
${MOBILE}                               id=clrcap.CCClient:id/spinner
${CROSS_BUTTON_ICON}                    id=clrcap.CCClient:id/iv_cancel
${ADD_NUMBER_BUTTON}                    xpath=//android.widget.TextView[@text="ADD NUMBER"]
${CALL_RECORD}                          id=clrcap.CCClient:id/textViewDisplay

${DropDown}                     id=clrcap.CCClient:id/spinner
${DropDown1}                    id=clrcap.CCClient:id/spinner
${DropDown2}                    xpath=(//android.widget.Spinner[@resource-id="clrcap.CCClient:id/spinner"])[2]

${Work}                         xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Work"]
${Home}                         xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Home"]
${Others}                       xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Other"]

${DEFAULT_OPTION}               id=android:id/text1

${YES_BUTTON_ON_CANCEL}         id=clrcap.CCClient:id/btnYes
${NO_BUTTON_ON_CANCEL}          id=clrcap.CCClient:id/btnNo
${Delete_button}                id=clrcap.CCClient:id/ib_toolbar_delete

${CAPTIONED_CALLED}             id=clrcap.CCClient:id/imageViewIcon
${CAPTION_ICON}                 id=clrcap.CCClient:id/imageViewIcon

${FONT}                         id=clrcap.CCClient:id/btn_font
${FONT_SCROLLBAR}               id=clrcap.CCClient:id/font_text_size_seek_bar

${CALL_NUMBER_OR_NAME}          xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewDisplay"])[1]
${CALL_NUMBER}                  xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewDisplay"])[1]

${CALL_NOW}                     id=clrcap.CCClient:id/btn_alert_call
${SEARCH_BAR}                   id=clrcap.CCClient:id/et_search

${NO_MATCHES_FOUND_TEXT}        id=clrcap.CCClient:id/textPlaceholder
${NO_MISSED_CALLS}              id=clrcap.CCClient:id/placeholderView
${NO_CALLS_TEXT}                xpath=//android.widget.TextView[@text="There are no calls"]
${YES_BUTTON_TO_DELETE_ALL_CALL_LOGS}    id=clrcap.CCClient:id/btn_alert_yes

${THEME_BUTTON}                 id=clrcap.CCClient:id/btn_color

${CAPTIONED_IMG}                xpath=(//android.widget.ImageView[@content-desc="CaptionedCall"])[1]
${DELETE_SINGLE_CALL}           xpath=(//android.widget.ImageView[@content-desc="DeleteItem"])[1]
${SINGLE_delete}                xpath=(//android.widget.ImageView[@content-desc="DeleteItem"])[1]

${CAPTIONS_ALL}                 xpath=//android.view.ViewGroup/android.widget.TextView[@resource-id='clrcap.CCClient:id/tv_caption']
${CAPTIONS_DELETE}              id=clrcap.CCClient:id/btn_extra_action

${ARROW_ALL}                    xpath=(//android.view.ViewGroup[@resource-id='clrcap.CCClient:id/contraint_layout'])
${ARROW_IMAGE}                  xpath=(//android.widget.ImageView[@content-desc="NextArrow"])[1]
${ARROW_IMAGE_OF_SECOND_CALL}         xpath=(//android.widget.ImageView[@content-desc="NextArrow"])[2]

${MISSED_CALL_NUMBER}           xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewDisplay"])[1]
${FIRST_MISSED_CALL_NUMBER}     xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewDisplay"])[1]

# Common Locators
${MAIN_MENU_TITLE}              id=clrcap.CCClient:id/tvMenuTitle
${SPINNER}                      id=clrcap.CCClient:id/spinner
${CALLER_NUMBER}                id=clrcap.CCClient:id/tvName
${CALLER_TIMER}                 xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvTimer"])[1]

# Dropdown Options
${DROPDOWN_MOBILE}              xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Mobile"]
${DROPDOWN_WORK}                xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Work"]
${DROPDOWN_HOME}                xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Home"]
${DROPDOWN_OTHER}               xpath=//android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Other"]

${CALL_LOG_ENTRY}               xpath=//android.view.ViewGroup[@resource-id='clrcap.CCClient:id/contraint_layout']
${CALL_LOG_HOME}                xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/mBottomMenu"]
${CALL_LOG_HOME_BUTTON}         xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btn_menu"]

${EDIT_BTN}                     id=clrcap.CCClient:id/btn_edit
${BTN_CALL_LOG}                 xpath=(//android.widget.RelativeLayout[@resource-id="clrcap.CCClient:id/btnCallLogs"]/android.view.ViewGroup/android.widget.LinearLayout)

${CALL_CREATE_CONTACT}          id=clrcap.CCClient:id/btn_alert_create_new

${CALL_LOG_CONTAINER}           id=clrcap.CCClient:id/container

# Buttons inside CALL LOGS tab
${SEARCH_BUTTON}                id=clrcap.CCClient:id/btn_search
${CALL_DETAILS}                 xpath=//android.widget.ListView[@resource-id="clrcap.CCClient:id/lv_search_result"]/android.view.ViewGroup[1]

# Call log list elements
${FIRST_CALL_NUMBER_CALL_LIST}  xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewDisplay"])[1]
${SECOND_CALL_NUMBER_CALL_LIST}  xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewDisplay"])[2]

${HOME_CALL_LOG_TILE}             id=clrcap.CCClient:id/btnCallLogs
${CALLLOG_BADGE_COUNTER}        xpath=//android.widget.RelativeLayout[@resource-id="clrcap.CCClient:id/btnCallLogs"]//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCount"]
${CALLLOG_BADGE}                xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCount"])[1]
${CALL_LOG_BADGE}               xpath=(//android.widget.TextView[@resource-id="clrcap.CCClient:id/textViewCount"])[1]
# 3-way call locators
${MERGED_CALL_HOME_BUTTON}      xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btnMenuLayout"]
${MERGED_CALL_TONE_BUTTON}      xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btn_tone"]
${MERGED_CALL_SPEED_BUTTON}     xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btn_pace"]
${MERGED_CALL_FONT_BUTTON}      xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btn_font"]

${THANK_YOU_MSG}             id=clrcap.CCClient:id/event_description

${SCROLL_DOWN_BUTTON}           id=clrcap.CCClient:id/ib_to_bottom

${INCOMING_CALL_ICON}        xpath=//android.widget.ImageView[@content-desc="IncomingCall"]
${OUTGOING_CALL_ICON}        xpath=//android.widget.ImageView[@content-desc="OutgoingCall"]
${MISSED_CALL_READ_ICON}          xpath=//android.widget.ImageView[@content-desc="MissedCallRead"]
${MISSED_CALL_UNREAD_ICON}          xpath=//android.widget.ImageView[@content-desc="MissedCallUnread"]

${CALL_LOG_ENTRIES_CLASS}    xpath=//android.widget.ListView/android.view.ViewGroup
${CALL_LOG_ICON_CLASS}       //android.widget.TextView[@resource-id="clrcap.CCClient:id/tvTimer"]

${CALL_LOG_TIME_LIST}    xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tvTimer"]
${CALL_LOG_DATE_TIME_AND_DURATION}        //android.widget.TextView[@resource-id="clrcap.CCClient:id/tv_caption_date"]