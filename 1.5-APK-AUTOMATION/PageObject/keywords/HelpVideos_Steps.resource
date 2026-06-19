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

the Help Videos screen is displayed
    Verify Help Videos Screen Is Displayed

the folllowing Help Video options are available:OVERVIEW,,USING CAPTIONS,CONTACTS & FAVORITES,CALL LOG,VOICEMAIL,SETTINGS,ADJUSTING VOLUME
    Verify Help Video Options Are Available

when the user taps on the button of the displayed Help video options; the correct Help video for the topic plays back
    Verify Help Video Playback For Each Topic
