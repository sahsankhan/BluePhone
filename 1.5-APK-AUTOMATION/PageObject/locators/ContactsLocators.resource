*** Variables ***
${CONTACT_APP}                  id=clrcap.CCClient:id/btnContacts
${CONTACT_LIST_TITLE}           id=clrcap.CCClient:id/tv_toolbar_title
${CONTACT_ADD_BUTTON}           id=clrcap.CCClient:id/btn_add_contact
${CONTACT_FIRST_NAME_FIELD}     id=clrcap.CCClient:id/et_first_name
${CONTACT_LAST_NAME_FIELD}      id=clrcap.CCClient:id/et_last_name
${CONTACT_PHONE_NUMBER_FIELD}   id=clrcap.CCClient:id/et_phone
${CONTACT_SAVED_PHONE_NUMBER}   id=clrcap.CCClient:id/textViewPhoneNumber
${CONTACT_SEARCH_BAR}           id=clrcap.CCClient:id/et_search
${CONTACT_CLEAR_SEARCH_BTN}     id=clrcap.CCClient:id/ib_clear
${CONTACT_EDIT_BTN}             id=clrcap.CCClient:id/btn_edit
${CONTACT_DELETE_BTN}           id=clrcap.CCClient:id/ib_toolbar_delete
${CONTACT_DELETE_YES_BTN}       xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btnYes"]
${CONTACT_HOME_BTN}             id=clrcap.CCClient:id/btn_menu
${CONTACT_NAME_IN_LIST}         id=clrcap.CCClient:id/textViewFullname
${POST_CALL_CONTACT_NAME}       id=clrcap.CCClient:id/tv_name
${CONTACT_SUPPORT_ENTRY}        xpath=//android.widget.TextView[@resource-id='clrcap.CCClient:id/textViewFullname' and @text='ClearCaptions']
${CONTACT_HEART_ON_AVATAR}      id=clrcap.CCClient:id/iv_contact_favorite
${CONTACT_DETAIL_FULL_NAME}     id=clrcap.CCClient:id/tv_full_name
${CONTACT_TOOLBAR_BACK}         id=clrcap.CCClient:id/ib_toolbar_back
${DEVICE_NUMBER_FROM_CONTACT}   id=clrcap.CCClient:id/my_number
${CONTACT_HEADER_ICON}          id=clrcap.CCClient:id/iv_toolbar_icon
${CONTACT_CANCEL_HEADER_BTN}    id=clrcap.CCClient:id/ib_toolbar_cancel
${CONTACT_REMOVE_NUMBER_ICON}   id=clrcap.CCClient:id/iv_cancel
${CONTACT_PHONE_FIELD_COUNT}    //android.widget.EditText[@resource-id="clrcap.CCClient:id/et_phone"]
${CONTACT_REMOVE_NUMBER_COUNT}  //android.widget.ImageView[@resource-id="clrcap.CCClient:id/iv_cancel"]
${CONTACT_ADD_NUMBER_BTN}       xpath=//android.widget.TextView[@text="ADD NUMBER"]
${CONTACT_ADD_NUMBER_ICON}      id=clrcap.CCClient:id/btn_add_field
${CONTACT_PHONE_TYPE_SPINNER}   id=clrcap.CCClient:id/spinner
${CONTACT_PHONE_TYPE_TEXT}      xpath=//*[@resource-id="clrcap.CCClient:id/spinner"]//*[@resource-id="android:id/text1"]
${CONTACT_PHONE_TYPE_COUNT}     //*[@resource-id="clrcap.CCClient:id/spinner"]//*[@resource-id="android:id/text1"]
${CONTACT_CANCEL_CONFIRM_MSG}   id=clrcap.CCClient:id/tvMessage
${CONTACT_CANCEL_YES_BTN}       xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btnYes"]
${CONTACT_CANCEL_NO_BTN}        xpath=//android.widget.Button[@resource-id="clrcap.CCClient:id/btnNo"]
${CONTACT_EDIT_HEADER}          xpath=//android.widget.TextView[@resource-id="clrcap.CCClient:id/tv_toolbar_title" and @text="EDIT CONTACT"]
${CONTACT_SEARCH_HEADER_CLOSE}  id=clrcap.CCClient:id/ib_toolbar_cancel
${CONTACT_DELETE_CONFIRM_MSG}   id=clrcap.CCClient:id/tvMessage
${CONTACT_SCROLL_BAR}           id=clrcap.CCClient:id/fsbContactDetails
${CONTACT_AVATAR_INITIALS}      id=clrcap.CCClient:id/txt_avatar_letter
${CONTACT_GRAY_HEART}           id=clrcap.CCClient:id/cb_favorite
${CONTACT_RED_HEART}            xpath=//android.widget.ImageView[@content-desc="Favorite selected"]
${CONTACT_NO_MATCHES_FOUND}     id=clrcap.CCClient:id/tv_empty
