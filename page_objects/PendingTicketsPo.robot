*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Page Object to maintain locators, methods and variables related to Pending tickets page.
Library             SeleniumLibrary
Library             String
Library             ../custom_libraries/CustomMethods.py
Resource            ../resources/Resources.robot
#----------------------------------------------------------------------------------------------------------------


*** Variables ***

#Locators
#----------------------------------------------------------------------------------------------------------------
${lblPendingTickets}        xpath://h1[text()='Pending Tickets']
${lnkTitleTitle}            xpath:(//a[@title='TicketTitle'])[1]
${lnkTicketStatus}          xpath:(//a[@title='TicketTitle']/ancestor::article//span[@class='hf-ticket-status_name'])[1]
${lnkTicketPriority}        xpath:(//a[@title='TicketTitle']/ancestor::article//div[@data-test-id='ticket-box_priority'])[1]
${lnkReply}                 xpath://a[@data-test-id='reply-link']//span
${lnkCannedAction}          xpath://span[@class='hf-u-vertical-super ']
${lblCannedActionHeader}    xpath://div[text()='Canned Action']
${liReplyToCustomerQuery}   xpath://li[@data-option-index=0 and text()='Reply to Customer Query']
${btnUseThis}               xpath://button[@data-test-id='hf-add-canned-action']
${btnAddReply}              xpath://button[@data-test-id='add-update-reply-button']
${btnAddingUpdate}          xpath://button[text()='Adding Update..']
${lblTicketStatus}          xpath://span[@class='hf-ticket-status_name']
${lblTicketPriority}        xpath://div[@data-test-id='ticket-box_priority']
${lblNoTagsFound}           xpath://div[@data-test-id='empty-tags-message']
${lblFirstTag}              xpath://div[@data-test-id='tags-container']/span[1]
${lblToastMessage}          xpath://div[@data-test-id='toast-message']
${lblDraftSaved}            xpath://span[text()='Draft Saved!']
${ulCannedActionList}       xpath://ul[@role='listbox']
${txtTicketSubject}         id:id_subject
${txtTicketMessage}         //div[@id='cke_1_contents']//p
${txtFullName}              id:id_name
${txtEmail}                 id:id_email
${txtPhone}                 id:id_phone
${btnCreateTicket}          xpath://button[text()='Create Ticket']
${lnkBrowseForFile}         id:attach-file-input
${lblCreationMessage}       xpath://div[@class='hf-custom-message-after-ticket-creation_content hf-editor-reset_list']
${lblModifiedStatus}        xpath://div[@class='hf-floating-editor_footer-container']//div[@data-test-id='ticket-box_status']
${lblModifiedPriority}      xpath://div[@class='hf-floating-editor_footer-container']//div[@data-test-id='ticket-box_status']
${lblModifiedTag}           xpath://div[@class='hf-floating-editor_footer-container']//div[@data-test-id='editor-add-tags-trigger']

#----------------------------------------------------------------------------------------------------------------

#Variables
#----------------------------------------------------------------------------------------------------------------
${TicketCreationMessage}    Your ticket has been created and you have been emailed instructions to activate your account with which you can track your ticket status
${NoTagsFoundMessage}       No Tags Found
${TicketUpdateMessage}      Ticket has been updated successfully
${TagUpdate}                3 Tags
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

##-------------------------------------------Keyword Header-------------------------------------------------------
##       Keyword to Navigate to Agent portal
##----------------------------------------------------------------------------------------------------------------
#
#Navigate to Agent portal
#    Go To                                           ${AgentPortalURL}
#    Wait Until Element Is Visible On The Page       ${lblPendingTickets}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to verify ticket created with default sratus and priority
#----------------------------------------------------------------------------------------------------------------

Verify ticket is created with default status and priority
    [Arguments]     ${TicketSubject}    ${StatusName}   ${PriorityName}
    ${TempXpath}=                                   Replace String      ${lnkTicketStatus}      TicketTitle  ${TicketSubject}
    Wait Until Page Contains Element                ${TempXpath}        timeout=50
    Wait Until Element Is Enabled                   ${TempXpath}        timeout=50
    Element Text Should Be                          ${TempXpath}        ${StatusName}           ignore_case=True
    ${TempXpath}=                                   Replace String      ${lnkTicketPriority}    TicketTitle  ${TicketSubject}
    Wait Until Page Contains Element                ${TempXpath}        timeout=50
    Wait Until Element Is Enabled                   ${TempXpath}        timeout=50
    Element Text Should Be                          ${TempXpath}        ${PriorityName}         ignore_case=True

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to Reply to ticket using canned action
#----------------------------------------------------------------------------------------------------------------

Reply to ticket using canned action and validate property changes
    [Arguments]     ${TicketSubject}    ${StatusName}   ${PriorityName}
    ${TempXpath}=                                   Replace String          ${lnkTitleTitle}      TicketTitle  ${TicketSubject}
    Wait Until Page Contains Element                ${TempXpath}            timeout=50
    Wait Until Element Is Enabled                   ${TempXpath}            timeout=50
    Click Element                                   ${TempXpath}
    Wait Until Element Is Visible On The Page       ${lblNoTagsFound}
    Element Text Should Be                          ${lblNoTagsFound}       ${NoTagsFoundMessage}
    Wait Until Element Is Visible On The Page       ${lnkReply}
    Click Element                                   ${lnkReply}
    Wait Until Element Is Visible On The Page       ${lblDraftSaved}
    Wait Until Element Is Visible On The Page       ${lnkCannedAction}
    Click Element                                   ${lnkCannedAction}
    zoomout
    Wait Until Page Contains Element                ${liReplyToCustomerQuery}            timeout=50
    Wait Until Element Is Enabled                   ${liReplyToCustomerQuery}            timeout=50
    Wait Until Element Is Visible                   ${liReplyToCustomerQuery}            timeout=50
    Double Click Element                            ${liReplyToCustomerQuery}
    Verify ticket property changes                  ${StatusName}           ${PriorityName}
    Click Element                                   ${btnAddReply}
    Click Element                                   ${btnAddReply}
    Wait Until The Page Does Not Contain Element    ${btnaddingupdate}
    Element Text Should Be                          ${lblToastMessage}      ${TicketUpdateMessage}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to Navigate to resources screen
#----------------------------------------------------------------------------------------------------------------

Verify ticket property changes
    [Arguments]     ${StatusName}   ${PriorityName}
    Element Text Should Not Be                      ${lblModifiedStatus}    ${StatusName}     ignore_case=True
    Element Text Should Not Be                      ${lblModifiedPriority}  ${PriorityName}   ignore_case=True
    Element Text Should Be                          ${lblModifiedTag}       ${TagUpdate}      ignore_case=True




