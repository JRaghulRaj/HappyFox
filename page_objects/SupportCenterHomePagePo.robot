*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Page Object to maintain locators, methods and variables related to Statuses page.
Library             SeleniumLibrary
Library             String
Library             ../custom_libraries/CustomMethods.py
Resource            ../resources/Resources.robot
#----------------------------------------------------------------------------------------------------------------

*** Variables ***

#Locators
#----------------------------------------------------------------------------------------------------------------
${txtWelcomeBanner}         xpath://div[text()='Welcome to our Support Center']
${txtTicketSubject}         id:id_subject
${txtTicketMessage}         //div[@id='cke_1_contents']//p
${txtFullName}              id:id_name
${txtEmail}                 id:id_email
${txtPhone}                 id:id_phone
${btnCreateTicket}          xpath://button[text()='Create Ticket']
${lnkBrowseForFile}         id:attach-file-input
${lblCreationMessage}       xpath://div[@class='hf-custom-message-after-ticket-creation_content hf-editor-reset_list']
#----------------------------------------------------------------------------------------------------------------

#Variables
#----------------------------------------------------------------------------------------------------------------
${TicketCreationMessage}    Your ticket has been created and you have been emailed instructions to activate your account with which you can track your ticket status
${ScreenshotPath}           C:/Users/dell/PycharmProjects/HappyFox/resources/TicketScreenshot.png
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a new priority as per the Arguments passed
#----------------------------------------------------------------------------------------------------------------

Navigate to Support center homepage
    Go To                                           ${SupportCenterURL}
    Wait Until Element Is Visible On The Page       ${txtWelcomeBanner}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a new priority as per the Arguments passed
#----------------------------------------------------------------------------------------------------------------

Fill in the ticket details
    [Arguments]     ${TicketSubject}    ${TicketMessage}    ${TicketFullName}   ${TicketEmail}  ${TicketPhone}
    Input Text                                      ${txtTicketSubject}     ${TicketSubject}
    Wait Until Element Is Visible On The Page       ${txtTicketMessage}
    Input Text                                      ${txtTicketMessage}     ${TicketMessage}
    Choose File                                     ${lnkbrowseforfile}     ${ScreenshotPath}
    Input Text                                      ${txtFullName}          ${TicketFullName}
    Input Text                                      ${txtEmail}             ${TicketEmail}
    Input Text                                      ${txtPhone}             ${TicketPhone}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a new priority as per the Arguments passed
#----------------------------------------------------------------------------------------------------------------

Create and validate ticket creation
    ${element}=           Get WebElement      ${btncreateticket}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${element}
    Wait Until Element Is Visible On The Page       ${lblCreationMessage}
    Element Text Should Be                          ${lblCreationMessage}   ${TicketCreationMessage}







