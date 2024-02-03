*** Settings ***
#----------------------------------------------------------------------------------------------------------------
Documentation       Page Object to maintain locators, methods and variables related to Priorities page.
Library             SeleniumLibrary
Library             String
Resource            ../resources/Resources.robot
#----------------------------------------------------------------------------------------------------------------

*** Variables ***

#Locators
#----------------------------------------------------------------------------------------------------------------
${lblPriorities}            xpath://div[text()='Priorities']
${btnAddNewPriority}        xpath://button[@data-test-id='new-priority']
${lblAddPriority}           xpath://div[text()='Add Priority']
${txtPriorityName}          xpath://input[@aria-label='Priority Name']
${txtPriorityDescription}   xpath://textarea[@data-test-id='form-field-description']
${btnAddPriority}           xpath://button[text()='Add Priority']
${btnAddingPriority}        xpath://button[text()='Adding Priority..']
${lnkPriorityName}          xpath://span[text()='PriorityName']
${lnkMakePriorityDefault}   xpath://span[text()='PriorityName']//following::td[3]//div[@class='hf-make-default']
${lblDefaultPriority}       xpath://span[text()='PriorityName']//following::td[3]//div[@data-test-id='default-priority']
${lblNameErrorMessage}      xpath://div[@data-test-id='form-field-name-error' and text()='Name must be unique']
${btnDeletePriority}        xpath://a[text()='Delete']
${ddlChoosePriority}        xpath://span[text()='Choose Priority']
${ddlPriorityNew}           xpath://li[text()='Low']
${btnDelete}                xpath://button[text()='Delete']
${btnDeleting}              xpath://button[text()='Deleting..']
${lblDeleteConfirmation}    xpath://div[@data-test-id='toast-message']
#----------------------------------------------------------------------------------------------------------------

#Variables
#----------------------------------------------------------------------------------------------------------------
${PriorityDeleteMessage}   Priority "PriorityName" is deleted successfully.
#----------------------------------------------------------------------------------------------------------------

*** Keywords ***

#-------------------------------------------Keyword Header-------------------------------------------------------
#       Keyword to create a new priority as per the Arguments passed
#----------------------------------------------------------------------------------------------------------------

Create new Priority
    [Arguments]     ${PriorityName}     ${PriorityDescription}
    Wait until element is visible on the page       ${btnAddNewPriority}
    Click Button                                    ${btnAddNewPriority}
    Wait until element is visible on the page       ${lblAddPriority}
    Input Text                                      ${txtPriorityName}              ${PriorityName}
    Input Text                                      ${txtPriorityDescription}       ${PriorityDescription}
    Click Button                                    ${btnAddPriority}
    Wait until the page does not contain element    ${btnAddingPriority}
    Page Should Not Contain Element                 ${lblNameErrorMessage}
    ${TempXpath}=                                   Replace String                  ${lnkPriorityName}        PriorityName  ${PriorityName}
    Wait until element is visible on the page       ${TempXpath}
    Page Should Contain Element                     ${TempXpath}

#-------------------------------------------Keyword Header-------------------------------------------------------
#      Keyword to make a priority as default
#----------------------------------------------------------------------------------------------------------------

Make Priority as default
    [Arguments]     ${PriorityName}
    ${TempXpath}=                                   Replace String                  ${lnkMakePriorityDefault}   PriorityName  ${PriorityName}
    Wait Until Page Contains Element                ${TempXpath}        timeout=50
    Wait Until Element Is Enabled                   ${TempXpath}        timeout=50
    ${element}=                                          Get WebElement      ${TempXpath}
    Execute Javascript    arguments[0].click();     ARGUMENTS    ${element}
    ${TempXpath}=                                   Replace String                  ${lblDefaultPriority}       PriorityName  ${PriorityName}
    Wait until element is visible on the page       ${TempXpath}

#-------------------------------------------Keyword Header-------------------------------------------------------
#      Keyword to delete a priority as per the argument passed
#----------------------------------------------------------------------------------------------------------------

Delete Priority
    [Arguments]     ${PriorityName}
    ${TempXpath}=                                   Replace String                  ${lnkPriorityName}        PriorityName  ${PriorityName}
    Click Element                                   ${TempXpath}
    Wait until element is visible on the page       ${btnDeletePriority}
    Click Element                                   ${btnDeletePriority}
    Wait until element is visible on the page       ${btndelete}
    ${present}=                                     Run Keyword And Return Status   Element Should Be Visible    ${ddlChoosePriority}

    IF  ${present}
        Click Element                                   ${ddlChoosePriority}
        Click Element                                   ${ddlPriorityNew}
    END

    Click Button                                    ${btndelete}
    Wait until the page does not contain element    ${btnDeleting}
    Wait until element is visible on the page       ${lblDeleteConfirmation}
    ${DeleteConfirmation}=                          Get Text                        ${lblDeleteConfirmation}
    ${ExpectedDeleteConfirmation}=                  Replace String                  ${PriorityDeleteMessage}        PriorityName  ${PriorityName}
    Should Be Equal As Strings                      ${DeleteConfirmation}           ${ExpectedDeleteConfirmation}
    Log                                             ${DeleteConfirmation}
    Wait until the page does not contain element    ${lblDeleteConfirmation}