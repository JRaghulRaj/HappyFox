*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation     A resource file with reusable keywords and variables.
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
#----------------------------------------------------------------------------------------------------------------

*** Variables ***
#----------------------------------------------------------------------------------------------------------------
${SupportCenterURL}     https://interview3.supporthive.com/new
${AgentPortalURL}       https://interview3.supporthive.com/staff/login
${AgentUsername}        Agent
${AgentPassword}        Agent@123
${BrowserName}          Chrome
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a webdriver and maximize browser window
#----------------------------------------------------------------------------------------------------------------

Create Webdriver and Maximize window
    Create Webdriver    ${BrowserName}
    Maximize Browser Window

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to close the browser session
#----------------------------------------------------------------------------------------------------------------

Close Browser session
    Close Browser

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to wait until an element is visible on the page for the given time
#----------------------------------------------------------------------------------------------------------------

Wait until element is visible on the page
    [Arguments]                                 ${page_locator}
    Wait Until Element Is Visible               ${page_locator}        timeout=70

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to wait until page does not contain an element for the given time
#----------------------------------------------------------------------------------------------------------------

Wait until the page does not contain element
    [Arguments]                                 ${page_locator}
    Wait Until Page Does Not Contain Element    ${page_locator}        timeout=50





