*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Page Object to maintain locators, methods and variables related to Agent portal login page.
Library             SeleniumLibrary
Library             String
Resource            ../resources/Resources.robot
Resource            ../page_objects/AgentPortalHomePagePo.robot
#----------------------------------------------------------------------------------------------------------------

*** Variables ***

#Locators
#----------------------------------------------------------------------------------------------------------------
${lblAgentLoginHeading}    xpath://h3[text()='Agent Login']
${txtAgentPortalUsername}  id:id_username
${txtAgentPortalPassword}  id:id_password
${btnLogin}                xpath://input[@value='Login']
${lnkStaffMenu}            xpath://div[@data-test-id='staff-menu']
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to Login to Agent portal using URL and other variables from Resources.robot
#----------------------------------------------------------------------------------------------------------------

Login to Agent portal
    Go To                                           ${AgentPortalURL}
    ${present}=                                     Run Keyword And Return Status   Element Should Be Visible   ${lblAgentLoginHeading}
    IF  ${present}
        Input Text                                  ${txtAgentPortalUsername}       ${AgentUsername}
        Input Password                              ${txtAgentPortalPassword}       ${AgentPassword}
        Click Button                                ${btnlogin}
    END
    Wait until element is visible on the page       ${lnkStaffMenu}

