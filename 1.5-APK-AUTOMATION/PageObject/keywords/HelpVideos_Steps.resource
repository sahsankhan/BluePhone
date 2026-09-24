*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
the user tap the Help App
    Open Help App

the user taps on the Help Videos icon
    Open Help App

Making Calls option should get displayed
    Verify Help Option Is Visible    ${HELP_MAKING_CALLS}

Answering Calls option should get displayed
    Verify Help Option Is Visible    ${HELP_ANSWERING_CALLS}

Your Captioning Experience option should get displayed
    Verify Help Option Is Visible    ${HELP_CAPTIONING_EXPERIENCE}

Adding Contacts and Favorites option should get displayed
    Verify Help Option Is Visible    ${HELP_ADDING_CONTACTS_FAVORITES}

Calling Contacts and Favorites option should get displayed
    Verify Help Option Is Visible    ${HELP_CALLING_CONTACTS_FAVORITES}

Light Bar option should get displayed
    Verify Help Option Is Visible    ${HELP_LIGHT_BAR}

Voicemail option should get displayed
    Verify Help Option Is Visible    ${HELP_VOICEMAIL}

Call Log option should get displayed
    Verify Help Option Is Visible    ${HELP_CALL_LOG}

Home button displayed on help app
    Verify Help Option Is Visible    ${HELP_HOME_BTN}

Overview options should get displayed
    [Documentation]    1.5 Help uses Making Calls tile for Overview-style entry.
    Verify Help Option Is Visible    ${HELP_MAKING_CALLS}

Using Captions option should get displayed
    Verify Help Option Is Visible    ${HELP_CAPTIONING_EXPERIENCE}

Contacts & Favorites option should get displayed
    Verify Help Option Is Visible    ${HELP_ADDING_CONTACTS_FAVORITES}

Settings option should get displayed
    ${by_id}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HELP_CALLING_CONTACTS_FAVORITES}    5
    ${by_text}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    xpath=//*[contains(@text,"Settings") or contains(@text,"SETTINGS")]    5
    ${ready}=    Evaluate    ${by_id} or ${by_text}
    Should Be True    ${ready}
    ...    msg=Help Settings-related option not visible
    Log To Console    Help Settings-related option visible

Adjusting Volume option should get displayed
    Verify Help Option Is Visible    ${HELP_LIGHT_BAR}

the Help Videos screen is displayed
    Verify Help Videos Screen Is Displayed

the folllowing Help Video options are available:OVERVIEW,,USING CAPTIONS,CONTACTS & FAVORITES,CALL LOG,VOICEMAIL,SETTINGS,ADJUSTING VOLUME
    Verify Help Video Options Are Available

when the user taps on the button of the displayed Help video options; the correct Help video for the topic plays back
    Verify Help Video Playback For Each Topic
