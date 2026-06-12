*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource

*** Keywords ***

the user is on the home screen
    Wait Until Element Is Visible    ${CONTACTS_APP_ICON}    ${DefaultTimeout}
    Wait Until Element Is Visible    ${CONTACTS_APP_TEXT}    ${DefaultTimeout}
    Text Should Be Visible    Contacts    
    Log To Console    Contacts app is visible, user is on home screen