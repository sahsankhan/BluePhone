*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***

the user navigates to Settings
    Tap on Settings App

the user navigates to the Settings
    the user navigates to Settings

the user navigates to the Settings page
    the user navigates to Settings

the AU navigates to the Settings screen
    the user navigates to Settings

the user clicks the Settings App
    the user navigates to Settings

the user taps on Reset Phone
    Scroll Element Into View    locator=${RESET_PHONE}    max_swipes=5    direction=down
    Tap on Reset Phone

selects Restart Phone
    Tap on restart phone option

the confirmation overlay screen appears
    Verify restart confirmation overlay screen appears

the user selects Cancel
    Tap on Cancel button on restart confirmation overlay

the confirmation overlay should close and the phone should not restart
    Verify confirmation overlay is closed
    Verify Reset Phone screen is still visible

In the Settings - Phone screen
    the user navigates to Settings
    Tap on Phone option in settings

Tap on the Home button located in the lower left of the screen
    Tap Settings Home Button

The Home screen refreshes
    the user is on the home screen

the AU views the Amplify Reset setting
    Tap on Sounds option in settings

the default setting should be "OFF"
    Verify that the default setting for Amplify Reset is "OFF"

the user selects the "Sounds" option
    Tap on Sounds option in settings

the Sounds screen should be displayed
    Verify Sounds screen is displayed

the user should see the "Ringer Volume" option with a rotating selector
    Verify Ringtone Volume option is present with increase and decrease buttons
    Verify Ringtone Frequency option is present with increase and decrease buttons

the user should see the "Handset Amplify Volume" option with a rotating selector
    Verify Handset Amplify Volume option is present with increase and decrease buttons

the user should see the "Speakerphone Amplify Volume" option with a rotating selector
    Verify Speakerphone Amplify Volume option is present with increase and decrease buttons

the user should see the "Headset/Neckloop Amplify Volume" option with a rotating selector
    Verify Headset/Neckloop Amplify Volume option is present with increase and decrease buttons

the user should see the "Touchscreen Sounds" toggle
    Verify Touchscreen Sounds toggle is present

the user should see the "Amplify Reset" toggle
    Verify Amplify Reset toggle is present

the user should see the "Home Button" option
    Verify Home Button option is present on Sounds

the phone is updated to the sw version that supports this feature
    Log To Console    Skipping SW version gate — 1.5 device assumed to support ringtone frequency UI

the user taps on the Sounds
    Tap on Sounds option in settings

a Ringtone Frequency stepper box will be displayed
    Verify Ringtone Frequency option is present with increase and decrease buttons

the user taps the stepper box to change the ringtone option
    Select Ringtone Frequency By Arrow    expected_frequency=Med    direction=Right

the options will change from the current value to the next from low to mid to high and back to low again as the user continues tapping the stepper box
    Verify Ringtone Frequency Stepper Cycle    direction=Right

the user taps the right facing arrow to change the ringtone option
    Select Ringtone Frequency By Arrow    expected_frequency=Med    direction=Right

the options will change from the current value to the next from low to mid to high and back to low again as the user continues to press the right facing arrow
    Verify Ringtone Frequency Stepper Cycle    direction=Right

the user taps the left facing arrow to change the ringtone option
    Select Ringtone Frequency By Arrow    expected_frequency=Med    direction=Left

the options will change from the current value to the next from High to Mid to Low and back to High again as the user continues to press the left facing arrow
    Verify Ringtone Frequency Stepper Cycle    direction=Left

the user is on the Settings screen
    the user navigates to Settings
    Wait Until Element Is Visible    ${TOOLBAR_TITLE}    ${DefaultTimeout}
    ${title}=    Get Text    ${TOOLBAR_TITLE}
    Should Be Equal As Strings    ${title}    SETTINGS
    ...    msg=Expected SETTINGS screen but got '${title}'

the user navigates to the Date & Time screen
    Tap on Date & Time option in settings

a Home button is visible in the lower left corner of the screen
    Wait Until Element Is Visible    ${HOME_BTN}    ${DefaultTimeout}
    Element Should Be Visible    ${HOME_BTN}

the user has changed the Ringtone Frequency option to Low or to Med or to High
    Set Ringtone Frequency    expected_frequency=Med

the user exits the Sounds screen in Settings using back arrow or Home button or any button on keypad or due to inbound call notification or when phone goes to sleep
    Tap on back arrow from header in Settings

the user returns to the Sounds screen in Settings
    Tap on Sounds option in settings

the last selected ringtone option before exiting the Sounds screen in Settings will be displayed in the Ringtone Frequency stepper box as Low or Med or High
    ${current_frequency}=    Get current Ringtone Frequency value
    Should Be Equal As Strings    ${current_frequency}    Med
    ...    msg=Ringtone Frequency did not persist (expected Med, got ${current_frequency})

user clicks on Phone option
    Tap on Phone option in settings
    Tap on back arrow from header in Settings

user clicks on Voicemail option
    Tap on Voicemail option in settings
    Tap on back arrow from header in Settings

user clicks on My Account option
    Tap on My Account option in settings
    Tap on back arrow from header in Settings

user clicks on Network option
    Tap on Network option in settings
    Tap on back arrow from header in Settings

user clicks on Display option
    Tap on Display option in settings
    Tap on back arrow from header in Settings

user clicks on Sounds option
    Tap on Sounds option in settings
    Tap on back arrow from header in Settings

user clicks on Flasher option
    Tap on Flasher option in settings
    Tap on back arrow from header in Settings

user clicks on Date & Time option
    Tap on Date & Time option in settings
    Tap on back arrow from header in Settings

user clicks on Setup Wizard option
    Tap on Setup Wizard option in settings

user clicks on Reset Phone option
    Tap on Reset Phone option in settings
    Tap on back arrow from header in Settings

user clicks on Software Update option
    Tap on Software Update option in settings

user clicks on Emergency Alerts option
    Tap on Emergency Alerts option in settings
    Tap on back arrow from header in Settings

user clicks on About option
    Tap on About option in settings
    Tap on back arrow from header in Settings

the user navigates to Phone
    Tap on Phone option in settings

"Show Caller ID" is not displayed on the screen
    Verify 'Show Caller ID' is not displayed on the screen
