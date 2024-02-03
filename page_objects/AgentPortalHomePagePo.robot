*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Page Object to maintain locators, methods and variables related to Agent portal Home page.
Library             SeleniumLibrary
Library             String
Resource            ../resources/Resources.robot
Resource            ../page_objects/StatusesPagePo.robot
Resource            ../page_objects/PrioritiesPagePo.robot
#----------------------------------------------------------------------------------------------------------------

*** Variables ***

#Locators
#----------------------------------------------------------------------------------------------------------------
${lblTicketsTitle}          xpath://span[text()='Tickets']
${mnuLeftHamburgerMenu}     xpath://div[@data-test-id='module-switcher_trigger']
${lnkManageStatuses}        xpath://li/a[text()='Statuses']
${lnkManagePriorities}      xpath://li/a[text()='Priorities']
${lnkStaffMenu}             xpath://div[@data-test-id='staff-menu']
${lnkLogout}                xpath://a[text()='Logout']
${lblLogoutMessage}         xpath://div[@class='confirmation']
#----------------------------------------------------------------------------------------------------------------

#Variables
#----------------------------------------------------------------------------------------------------------------
${SuccessfulLogoutMessage}  You have logged out successfully.
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to Navigate to resources screen
#----------------------------------------------------------------------------------------------------------------

Navigate to Statuses Screen
    Click Element                                   ${mnuLeftHamburgerMenu}
    Wait until element is visible on the page       ${lnkManageStatuses}
    Click Element                                   ${lnkManageStatuses}
    Wait until element is visible on the page       ${lblstatusname}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to Navigate to priorities screen
#----------------------------------------------------------------------------------------------------------------

Navigate to Priorities Screen
    Mouse Over                                      ${mnuLeftHamburgerMenu}
    Wait until element is visible on the page       ${lnkManagePriorities}
    Click Element                                   ${lnkManagePriorities}
    Wait until element is visible on the page       ${lblPriorities}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to Navigate to logout from Agent portal
#----------------------------------------------------------------------------------------------------------------

Logout from the Agent portal
    Wait until element is visible on the page       ${lnkStaffMenu}
    Click Element                                   ${lnkStaffMenu}
    Wait until element is visible on the page       ${lnkLogout}
    Click Element                                   ${lnkLogout}
    Wait until element is visible on the page       ${lblLogoutMessage}
    Element Text Should Be                          ${lblLogoutMessage}     ${SuccessfulLogoutMessage}   ignore_case=True


