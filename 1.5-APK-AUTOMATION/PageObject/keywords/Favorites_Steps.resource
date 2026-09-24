*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***
the user clicks the Favorites App
    Open Favorites App

the user clicks on the Favorites App
    Open Favorites App

add contact to favorite
    Ensure ClearCaptions Favorite Exists

ensure at least one contact is marked as a favorite
    Ensure ClearCaptions Favorite Exists

taps on the Edit button
    Tap Favorites Edit Button

taps on the remove button for all contacts
    Remove All Favorites On Edit Screen

clicks on the Save button
    Tap Favorites Save Button

taps on the remove button for all contacts and clicks on the Save button
    Clear All Favorites On Favorites Screen

Add Favorites text should be present in the center of the screen
    Verify Add Favorites Empty Text Is Displayed

contacts added to favorites should be displayed
    ${support_name}=    Get Value From Yaml File    user    verificationSupportName
    Verify Contact Appears In Favorites List    ${support_name}

if the user selects YES from the favorites removal confirmation and they navigate to the Favorites section
    Navigate To Home Screen
    Open Favorites App
    Log To Console    Navigated to Favorites after removing contact favorite

the contact is no longer displayed in the favorites list
    ${contact_name}=    Get Value From Yaml File    user    verificationName2
    ${visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${FAVORITES_CONTACT_NAME}    5
    IF    not ${visible}
        Log To Console    Favorites list empty / no contact rows — removal verified
        RETURN
    END
    ${contacts}=    Get WebElements    ${FAVORITES_CONTACT_NAME}
    FOR    ${contact}    IN    @{contacts}
        ${name}=    Set Variable    ${contact.text}
        Should Not Contain    ${name}    ${contact_name}
        ...    msg=Removed contact '${contact_name}' still appears in Favorites as '${name}'
    END
    Log To Console    Verified '${contact_name}' is not in Favorites list
