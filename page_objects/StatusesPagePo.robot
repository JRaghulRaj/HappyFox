*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Page Object to maintain locators, methods and variables related to Statuses page.
Library             SeleniumLibrary
Library             Collections
Library             String
Resource            ../resources/Resources.robot
#----------------------------------------------------------------------------------------------------------------

*** Variables ***

#Locators
#----------------------------------------------------------------------------------------------------------------
${lblStatusName}            xpath://div[text()='STATUS NAME']
${btnAddNewStatus}          xpath://button[@data-test-id='new-status']
${lblAddStatus}             xpath://div[text()='Add Status']
${txtStatusName}            xpath://input[@aria-label='Status Name']
${ddlBehavior}              xpath://div[@aria-label='Behavior']
${txtBehavior}              xpath://div[@class='ember-power-select-search']/input
${txtDescription}           xpath://textarea[@data-test-id='form-field-description']
${btnAddStatus}             xpath://button[text()='Add Status']
${btnAddingStatus}          xpath://button[text()='Adding Status...']
${lnkStatusName}            xpath://div[text()='StatusName']
${lnkMakeDefault}           xpath://div[text()='StatusName']//following::td[3]//a
${lblDefaultStatus}         xpath://div[text()='StatusName']//following::td[3]//div[@data-test-id='default-status']
${lnkDeleteStatus}          xpath://a[text()='Delete']
${btnDelete}                xpath://button[text()='Delete']
${btnDeleting}              xpath://button[text()='Deleting..']
${lblChangeDefaultStatus}   xpath://header[text()='Change the default status to']
${ddlChooseStatus}          xpath://span[text()='Choose Status']
${ddlStatusNew}             xpath://li[text()='New']
${lblNameErrorMessage}      xpath://div[@data-test-id='form-field-name-error' and text()='Name must be unique']
${lblDeleteConfirmation}    xpath://div[@data-test-id='toast-message']
#----------------------------------------------------------------------------------------------------------------

#Variables
#----------------------------------------------------------------------------------------------------------------
${StatusDeleteMessage}   	Status "StatusName" is deleted successfully.
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a new priority as per the Arguments passed
#----------------------------------------------------------------------------------------------------------------

Create new Status
    [Arguments]     ${StatusName}       ${Behavior}     ${Description}
    Wait until element is visible on the page       ${btnAddNewStatus}
    Click Button                                    ${btnAddNewStatus}
    Wait until element is visible on the page       ${lblAddStatus}
    Input Text                                      ${txtStatusName}                ${StatusName}
    Click Element                                   ${ddlBehavior}
    Input Text                                      ${txtBehavior}                  ${Behavior}
    Input Text                                      ${txtDescription}               ${Description}
    Click Button                                    ${btnAddStatus}
    Wait until the page does not contain element    ${btnAddingStatus}
    Page Should Not Contain Element                 ${lblNameErrorMessage}          ignore_case=True
    ${TempXpath}=                                   Replace String                  ${lnkStatusName}        StatusName  ${StatusName}
    Wait until element is visible on the page       ${TempXpath}
    Page Should Contain Element                     ${TempXpath}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a new priority as per the Arguments passed
#----------------------------------------------------------------------------------------------------------------

Make Status as default
    [Arguments]     ${StatusName}
    ${TempXpath}=                                   Replace String                  ${lnkmakedefault}       StatusName  ${StatusName}
    Wait Until Page Contains Element                ${TempXpath}        timeout=50
    Wait Until Element Is Enabled                   ${TempXpath}        timeout=50
    ${element}=                                     Get WebElement      ${TempXpath}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${element}
    ${TempXpath}=                                   Replace String                  ${lblDefaultStatus}     StatusName  ${StatusName}
    Wait until element is visible on the page       ${TempXpath}

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a new priority as per the Arguments passed
#----------------------------------------------------------------------------------------------------------------

Delete Status
    [Arguments]     ${StatusName}
    ${TempXpath}=                                   Replace String                  ${lnkStatusName}        StatusName  ${StatusName}
    Click Element                                   ${TempXpath}
    Wait Until Keyword Succeeds	        1 min       3 sec       Load until delete Status options are present
    ${present}=                                     Run Keyword And Return Status   Element Should Be Visible   ${ddlChooseStatus}
    IF  ${present}
        Click Element                                   ${ddlChooseStatus}
        Click Element                                   ${ddlStatusNew}
    END
    Click Button                                    ${btndelete}
    Wait until the page does not contain element    ${btnDeleting}
    Wait until element is visible on the page       ${lblDeleteConfirmation}
    ${DeleteConfirmation}=                          Get Text                        ${lblDeleteConfirmation}
    ${ExpectedDeleteConfirmation}=                  Replace String                  ${StatusDeleteMessage}        StatusName  ${StatusName}
    Should Be Equal As Strings                      ${DeleteConfirmation}           ${ExpectedDeleteConfirmation}
    Log                                             ${DeleteConfirmation}
    Wait until the page does not contain element    ${lblDeleteConfirmation}


Load until delete Status options are present
    ${present}=                                     Run Keyword And Return Status   Wait Until Element Is Visible   ${lnkDeleteStatus}  timeout=5
    IF  ${present}
        Wait Until Element Is Visible                   ${lnkDeleteStatus}  timeout=5
        Click Element                                   ${lnkDeleteStatus}
    ELSE
        Reload Page
        Wait Until Element Is Visible                   ${lnkDeleteStatus}  timeout=5
        Click Element                                   ${lnkDeleteStatus}
    END
    Wait until element is visible on the page       ${btndelete}