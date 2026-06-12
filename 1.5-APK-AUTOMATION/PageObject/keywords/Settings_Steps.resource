*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***

the user navigates to Settings
    Tap on Settings App

the user taps on Reset Phone
    # Scroll Page    direction=down
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