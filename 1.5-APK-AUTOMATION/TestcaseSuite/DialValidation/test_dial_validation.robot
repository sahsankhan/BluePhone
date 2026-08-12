*** Settings ***
Resource    ../../PageObject/keywords/CommonKeywords.resource
Resource    ../../PageObject/keywords/TestLifecycle.resource
Suite Setup    Suite Setup
Suite Teardown    Suite Teardown
Test Setup    Dial Validation Test Setup
Test Teardown    Dial Validation Test Teardown

*** Test Cases ***
Scenario: Dial And Validate All Phone Numbers
    [Tags]    dial_validation    countly
    Given a list of multi-digit phone numbers is available in the input file
    When the script reads each phone number one by one
    Then all phone numbers should be dialled and validated
    And Verify countly events for the dialled number
