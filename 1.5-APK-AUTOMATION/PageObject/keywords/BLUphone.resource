# *** Settings ***
# Library    OperatingSystem
# Library    JSONLibrary
# Library    Collections
# Library    DateTime
# Library    ${CURDIR}/../../../panacea_runtime/MobAppTestLibrary/
# Library    ../../Utility/android_input_events.py
# Library    String
# Resource    ../locators/locators.resource
# Resource    ../locators/HomeScreen.resource
# Resource    ../locators/PostCallScreen.resource
# Resource    ../locators/Settings.resource
# Resource    ../locators/CallLog.resource
# Resource    CommonKeywords.resource
# Library    ../../Utility/FuzzyLogic.py

# *** Variables ***
# ${SCRIPT2_CAPTION_FILE_PATH}    ClearCaptionsPOC/ConfigFiles/Scipt2_caption.txt
# ${timeout}    15
# ${UDID}    None
# ${seconds}    None
# ${Post_call_contact_name}    None

# *** Keywords ***
# user is on BLUphone's home screen
#     Wait Until Element Is Visible    ${My_Number}
    
# user clicks the "Contacts" icon
#     Element Should Be Visible    ${Contacts_button}
#     Click Element    ${Contacts_button}

# user should be navigated to the Contacts section of the phone
#     ${Title}    Get Text    ${Contacts_title}
#     Should Be Equal    ${Title}    CONTACTS

# user clicks the "Add" button
#     Click Element    ${Contact_Add_Button}

# adds the "First Name" and "Last Name"
#     Input Text    ${Contact_Firstname}    Rohan
#     Input Text    ${Contact_Lastname}    S

# adds the "Phone Number"
#     Input Text    ${Contact_Phone_Number}    123

# clicks the "Save" button
#     BuiltIn.Sleep    10s
#     Log To Console    Please click manually on Save button

# user should see the newly saved contact's details
#     ${New_contact_name}    Get Text    ${Contact_Full_Name}
#     Should Be Equal    ${New_contact_name}    Rohan S

# user clicks the "Home" button
#     Click Element    ${Home_button}

# user should be navigated back to BLUphone's home screen
#     Wait Until Element Is Visible    ${My_Number}

# searches for the newly saved contact in the search box
#     Input Text    ${Search_Box}    Rohan S

# user should see the contact in the list
#     ${Searched_contact_name}    Get Text    ${Contact_Name}
#     Should Be Equal    ${Searched_contact_name}    Rohan S

# user clicks on the newly saved contact
#     Click Element    ${Searched_contact_full_name}

# the contact details screen is displayed
#     ${New_contact_name}    Get Text    ${Contact_Full_Name}
#     Should Be Equal    ${New_contact_name}    Rohan S

# user clicks the "Favorites" icon
#     Element Should Be Visible    ${Favorite_icon}
#     Click Element    ${Favorite_icon}

# a popup should be displayed saying: "Are you sure you want to add to Favorites?" with "Yes" and "No" as options
#     Element Should Be Visible    ${Add_fav_confirmation_message}

# user clicks the "Yes" option
#     Click Element    ${Yes_button}

# the contact initial icon should display a favorite icon on it
#     Element Should Be Visible    ${fav_icon_on_contact}

# user search for ${Searched_Contact_Name} in the contact list
#     Element Should Be Visible    ${Search_Box}
#     Click Element    ${Search_Box}
#     Input Text    ${Search_Box}    ${Searched_Contact_Name}

# user taps on the searched contact
#     Element Should Be Visible    ${Contact_Name}
#     Click Element    ${Contact_Name}

# the contact detail page gets displayed to the user
#     Element Text Should Be    ${Contact_Full_Name}    Dhaval IVR

# user taps on the phone number
#     Click Element    ${Contact_Phone_Number_Dhaval}

# the call gets initiated
#     BuiltIn.Sleep    10s
#     Wait Until Element Is Visible    ${Captions_screen}

# user should be able to see ${Searched_contact_name} contact is already added to Favorites
#     ${status}    ${error}=    Run Keyword And Ignore Error    Element Should Be Visible    //android.widget.TextView[@resource-id='clrcap.CCClient:id/txt_fav_contact_name' and @text='${Searched_contact_name}']
    
#     IF    '${status}' == 'FAIL'
#         Log    First XPath not found, trying second XPath    level=WARN
#         Element Should Be Visible    //android.widget.TextView[@resource-id="clrcap.CCClient:id/txt_fav_contact_name" and @text="${Searched_contact_name}"]
#         ${Contact_name}=    Get Text    //android.widget.TextView[@resource-id="clrcap.CCClient:id/txt_fav_contact_name" and @text="${Searched_contact_name}"]
#     ELSE
#         ${Contact_name}=    Get Text    //android.widget.TextView[@resource-id='clrcap.CCClient:id/txt_fav_contact_name' and @text='${Searched_contact_name}']
#     END

#     Should Be Equal    ${Contact_name}    ${Searched_contact_name}

# user taps on the favorite card of the ${Searched_contact_name} contact
#     Click Element    //android.widget.TextView[@resource-id='clrcap.CCClient:id/txt_fav_contact_name' and @text='${Searched_contact_name}']

# I hangup the call manually
#     BuiltIn.Sleep    10s
#     Log To Console    Please hangup the ongoing call

# User navigates to homepage
#     BuiltIn.Sleep    10s
#     ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${post_call_screen_options_button}
#     IF    ${is_visible}
#         Click Element    ${post_call_screen_options_button}
#         Click Element    ${post_call_screen_home_button}
#     ELSE
#         Click Element    ${post_call_screen_home_button}
#     END

# user is on post call screen
#     BuiltIn.Sleep    10s
#     ${Post_call_contact_name}    Get Text    ${post_call_screen_contact_name}
#     Set Global Variable    ${Post_call_contact_name}
#     ${Post_call_duration}    Get Text    ${post_call_screen_call_duration}
#     ${time_parts}=    Split String    ${Post_call_duration}    separator=:
#     ${seconds}=    Set Variable    ${time_parts}[1]
#     Set Global Variable    ${seconds}

# opens call log
#     Element Should Be Visible    ${call_log_button}
#     Click Element    ${call_log_button}
#     BuiltIn.Sleep    5s

# user verifies the call duration of the recent call log 
#     ${recent_call_contact_name}    Get Text    ${Recent_call_log_name}
#     ${Recent_log_call_duration}    Get Text    ${Recent_call_log_duration}
#     ${cleaned}=    Remove String    ${Recent_log_call_duration}    sec
#     ${parts}=    Split String    ${cleaned.strip()}
#     ${seconds_call_log}=    Set Variable    ${parts}[-1]
    
#     Should Be Equal    ${Post_call_contact_name}    ${recent_call_contact_name}
#     Should Be Equal    ${seconds}    ${seconds_call_log}

# the user dials a number using the dialpad
#     ${did_number}    Get Value From Yaml File    devices    did
#     ${did_formated_number}    Get Value From Yaml File    devices    formated_did
#     Dial Number With Keycodes    ${did_number}
#     BuiltIn.Sleep    1s
#     ${Dialled_Number}    Get Text    ${DIALLED_NUMBER_TEXT}    
#     Should Be Equal As Strings    ${Dialled_Number}    ${did_formated_number}    
#     ${Cleaned_Number}=    Replace String    ${Dialled_Number}    (    ${EMPTY}
#     ${Cleaned_Number}=    Replace String    ${Cleaned_Number}    )    ${EMPTY}
#     ${Cleaned_Number}=    Replace String    ${Cleaned_Number}    -    ${EMPTY}
#     ${Cleaned_Number}=    Replace String    ${Cleaned_Number}    ${SPACE}    ${EMPTY}
#     Should Be Equal    ${Cleaned_Number}    ${did_number}
#     Element Should Be Visible    ${DIAL_A_NUMBER_ICON}    ${timeout}    
#     Element Should Be Visible    ${DIAL_A_NUMBER_TEXT}    ${timeout}
#     Capture Page Screenshot

# initiates the outbound call
#     Make Call With Retry
#     Capture Page Screenshot
#     BuiltIn.Sleep    120s

# Make Call With Retry
#     ${did_number}    Get Value From Yaml File    devices    did
#     ${RETRY_LIMIT}    Set Variable    3
#     ${RETRY_LIMIT_INT}    Convert To Integer    ${RETRY_LIMIT}
#     FOR    ${index}    IN RANGE    ${RETRY_LIMIT_INT}
#         Make Call
#         Get Make Call Status
#         Press Speaker Button    udid=${UDID}
#         ${button_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${POST_CALL_SCREEN_CLOSE_BUTTON}    30
#         Run Keyword If    ${button_visible}    Stop Container
#         Run Keyword If    ${button_visible}    Derive Sip Logs    sip_failure_${index}.log
#         Run Keyword If    ${button_visible}    Remove Container
#         Run Keyword If    ${button_visible} and ${index} < ${RETRY_LIMIT_INT - 1}    Dial Number With Keycodes    ${did_number}
#         Run Keyword If    not ${button_visible}    Exit For Loop
#     END

#     Run Keyword If    ${button_visible}    Fail    Call is not getting connected after ${RETRY_LIMIT_INT} retries.

# captions should be displayed
#     Wait Until Element Is Visible    ${post_call_screen_options_button}    ${timeout}
#     Wait Until Element Is Visible    ${Captions_screen}    ${timeout}
#     ${Caption_Text}=    Get Text    ${Captions_screen}
#     Create File    ${REPORT_DIR}/captions.txt    ${Caption_Text}
#     Capture Page Screenshot

# the user ends the call
#     Press Speaker Button    udid=${UDID}
#     Stop Container    
#     Derive Sip Logs    sip.log
#     Remove Container
#     Capture Page Screenshot

# post-call screen appears with captions
#     BuiltIn.Sleep    10s
#     Wait Until Element Is Visible    ${POST_CALL_SCREEN_TOTAL_TIME}    ${timeout}
#     Verify Call Duration Timer Is Frozen
#     Wait Until Element Is Visible    ${POST_CALL_SCREEN_CALLER_NAME}    ${timeout}
#     Wait Until Element Is Visible    ${POST_CALL_SCREEN_OPTION_BUTTON}    ${timeout}
#     Wait Until Element Is Visible    ${POST_CALL_SCREEN_CLOSE_BUTTON}    ${timeout}
#     Capture Page Screenshot

# Verify Call Duration Timer Is Frozen
#     ${before_5_seconds}    Get Text    ${POST_CALL_SCREEN_TOTAL_TIME}
#     BuiltIn.Sleep    5s
#     ${after_5_seconds}    Get Text    ${POST_CALL_SCREEN_TOTAL_TIME}
#     Should Be Equal As Strings    ${before_5_seconds}    ${after_5_seconds}

# call log record appears with captions
#     BuiltIn.Sleep    3
#     Open Android Activity    clrcap.CCClient    .ui.feature.calllog.CallLogUIActivity    ${UDID}
#     BuiltIn.Sleep    5
#     Wait Until Element Is Visible    ${CAPTIONED_BUTTON}    ${timeout}
#     Click Element    ${CAPTIONED_BUTTON}
#     ${EXPECTED_NUMBER}=    Get Value From Yaml File    devices    did
#     BuiltIn.Sleep    3
#     Wait Until Element Is Visible    ${FIRST_CONTACT_NUMBER_TEXT}    ${timeout}
#     ${text}    Get Text    ${FIRST_CONTACT_NUMBER_TEXT}
#     ${FORMATTED_NUMBER}=   Format Any Phone Number    ${EXPECTED_NUMBER}
#     Should Be Equal As Strings    ${text}    ${FORMATTED_NUMBER}
#     Tap When Number Matches    ${EXPECTED_NUMBER}
#     Validate Caption File Similarity With Threshold    ${REPORT_DIR}/captions.txt    ${SCRIPT2_CAPTION_FILE_PATH}    threshold=70
#     Capture Page Screenshot

# Validate Caption File Similarity With Threshold
#     [Arguments]    ${actual_file}    ${expected_file}    ${threshold}
#     Trim Before First Comma    ${actual_file}
#     BuiltIn.Sleep    2s
#     Trim After Word            filepath=${actual_file}    word=Bye.
#     BuiltIn.Sleep    2s
#     Fix File                   ${actual_file}
#     ${result}=    Validate Similarity    ${actual_file}    ${expected_file}    threshold=${threshold}
#     Run Keyword If    '${result["result"]}' == 'FAIL'    Fail    Similarity check failed with score ${result["fuzzy_score"]}

# Dial Number With Keycodes
#     [Arguments]    ${number_to_dial}
#     ${digits}=     Convert To List    ${number_to_dial}
#     FOR    ${digit}    IN    @{digits}
#         ${key_name}=    Set Variable    KEY_EVENT_${digit}
#         ${keycode}=     Get Value From Yaml File    keycodes    ${key_name}
#         Press Keycode   ${keycode}
#         BuiltIn.Sleep           0.3s
#     END
    
# the Post-call Review setting is confirmed to be ON
#     Open Android Activity    clrcap.CCClient    .ui.feature.settings.phone.captions.CaptionsSettingsActivity    ${UDID}
#     Wait Until Element Is Visible    ${POST_CALL_REVIEW_ON}    ${timeout}

# Tap When Number Matches
#     [Arguments]    ${EXPECTED_NUMBER}
#     ${FORMATTED_NUMBER}=   Format Any Phone Number    ${EXPECTED_NUMBER}
#     Wait Until Element Is Visible    ${CONTACT_NUMBER_TEXT}    ${timeout}
#     ${text_elements}=      Get WebElements    ${CONTACT_NUMBER_TEXT}
#     ${count}=              Get Length    ${text_elements}
#     ${match_found}=        Set Variable    False

#     FOR    ${index}    IN RANGE    ${count}
#         ${text}=    Get Text    ${text_elements[${index}]}
#         Log    Checking if ${text} == ${FORMATTED_NUMBER}

#         Run Keyword If    "'${text}'" == "'${FORMATTED_NUMBER}'"    Set Test Variable    ${match_found}    True
#         Run Keyword If    "'${text}'" == "'${FORMATTED_NUMBER}'"    Click Element    xpath=(//android.view.View[@resource-id="clrcap.CCClient:id/cal_log_det_click_area"])[${index + 1}]
#         Run Keyword If    "'${text}'" == "'${FORMATTED_NUMBER}'"    Exit For Loop
#     END

#     Run Keyword Unless    ${match_found}    Fail    No matching contact number found for ${FORMATTED_NUMBER}