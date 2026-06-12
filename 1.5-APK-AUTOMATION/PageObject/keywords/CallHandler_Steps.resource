*** Settings ***
Resource   ${CURDIR}/../../PageObject/keywords/CommonKeywords.resource
*** Variables ***

*** Keywords ***

an inbound call is placed to the Assisted User
    Initiate Primary Inbound Call

the Assisted User answers the call
    Press Speaker Button    udid=${UDID}
    Sleep    5s    Adding sleep to ensure call is fully connected before proceeding
    Remove Primary Container    type=OB

