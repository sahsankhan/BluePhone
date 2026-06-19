*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
the user clicks the Favorites App
    Open Favorites App

the user clicks on the Favorites App
    Open Favorites App

add contact to favorite
    Ensure ClearCaptions Favorite Exists

taps on the Edit button
    Tap Favorites Edit Button

taps on the remove button for all contacts
    Remove All Favorites On Edit Screen

clicks on the Save button
    Tap Favorites Save Button

taps on the remove button for all contacts and clicks on the Save button
    Tap Favorites Edit Button
    Remove All Favorites On Edit Screen
    Tap Favorites Save Button

Add Favorites text should be present in the center of the screen
    Verify Add Favorites Empty Text Is Displayed

contacts added to favorites should be displayed
    ${support_name}=    Get Value From Yaml File    user    verificationSupportName
    Verify Contact Appears In Favorites List    ${support_name}
