*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Main Sanity suite file where the Test cases are maintained
Library             SeleniumLibrary
Library             ../custom_libraries/CustomMethods.py
Suite Setup          Create webdriver and maximize window
Suite Teardown       Close Browser session
Resource            ../resources/Resources.robot
Resource            ../page_objects/SupportCenterHomePagePo.robot
Resource            ../page_objects/AgentLoginPagePo.robot
Resource            ../page_objects/AgentPortalHomePagePo.robot
Resource            ../page_objects/StatusesPagePo.robot
Resource            ../page_objects/PendingTicketsPo.robot
#----------------------------------------------------------------------------------------------------------------


*** Variables ***

#Test case specific variables which are passed as arguments
#----------------------------------------------------------------------------------------------------------------
${StatusName}           Issue created
${Behavior}             Pending
${StatusDescription}    Status when a new ticket is created in HappyFox
${PriorityName}         Assistance required
${PriorityDescription}  Priority of the newly created tickets
${TicketSubject}        Ticket subject New.
${TicketMessage}        This is a ticket message.
${TicketFullName}       Sample Full Name
${TicketEmail}          sampleticketmail@gmail.com
${TicketPhone}          9566039068
#----------------------------------------------------------------------------------------------------------------
*** Test Cases ***

#-------------------------------------------Test case Header-----------------------------------------------------
#       Test case to validate Status and Ticket creation as per the input provided in variables
#----------------------------------------------------------------------------------------------------------------

Validate Status and Priority Creation
    [Tags]      SanityGroup1        SanityGroup2
    TRY
        Login to Agent portal
        Navigate to Statuses Screen
        Create new Status               ${StatusName}       ${Behavior}             ${StatusDescription}
        Navigate To Priorities Screen
        Create new Priority             ${PriorityName}     ${PriorityDescription}
    EXCEPT
        Fail    Exception occured. Verify and Rerun test.
    END


#-------------------------------------------Test case Header-----------------------------------------------------
#       Test case to make Status and Priority as default and validate new ticket creation.
#       Varibales are taken from the varibles keyword and passed as arguments to the keywords.
#----------------------------------------------------------------------------------------------------------------

Make Status and Priority as default and validate new ticket creation
    [Tags]      SanityGroup1
    TRY
        Navigate To Statuses Screen
        Make Status As Default                 ${StatusName}
        Navigate To Priorities Screen
        Wait Until Keyword Succeeds	        2 min       5 sec       Make Priority As Default               ${PriorityName}
        Navigate to Support center homepage
        Fill in the ticket details              ${TicketSubject}    ${TicketMessage}    ${TicketFullName}   ${TicketEmail}  ${TicketPhone}
        Create and validate ticket creation
#        Navigate To Agent Portal
        Login To Agent Portal
        Wait Until Keyword Succeeds	        1 min       5 sec       Verify ticket is created with default status and priority   ${TicketSubject}    ${StatusName}   ${PriorityName}
        Reply to ticket using canned action and validate property changes     ${TicketSubject}    ${StatusName}   ${PriorityName}
    EXCEPT
        Fail    Exception occured. Verify and Rerun test.
    END

#-------------------------------------------Test case Header-----------------------------------------------------
#       Test case to Delete Status and Priority and Logout
#----------------------------------------------------------------------------------------------------------------

Delete Status and Priority and Logout
    [Tags]          SanityGroup1        SanityGroup2
    TRY
        Login to Agent portal
        Navigate To Statuses Screen
        Delete Status                   ${StatusName}
        Navigate To Priorities Screen
        Delete Priority                 ${PriorityName}
        Logout from the Agent portal
    EXCEPT
        Fail    Exception occured. Verify and Rerun test.
    END


