*** Settings ***
Documentation   Data-driven tests in Login 
...             use variations of invalid login parameters
Test Template   Login with Invalid Credentials Should Fail
Resource        resource.robot 


*** Test Cases ***               EMAIL            PASSWORD
Invalid Email                    invalid          ${VALID_PASSWORD}
Invalid Password                 ${VALID_EMAIL}   invalid
Invalid Email And Password       invalid          whatever
Empty Email                      ${EMPTY}         ${VALID_PASSWORD}
Empty Password                   ${VALID_EMAIL}   ${EMPTY}
Empty Email And Password         ${EMPTY}         ${EMPTY}


*** Keywords ***
Login with Invalid Credentials Should Fail
    [Arguments]     ${email}    ${password}
    When Login with ${email} and ${password}
    Then Body Message Is "User does not exist."
    And Body Status Is "fail"
    And Status Code Is 404

