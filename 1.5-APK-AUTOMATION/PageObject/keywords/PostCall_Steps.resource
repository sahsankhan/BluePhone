*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***

the call should be recorded as an answered call in the Call Log
    Close Post Call Review Screen
    Tap on Call Log App