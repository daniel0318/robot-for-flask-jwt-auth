*** Settings ***
Documentation   Test timeout functionality
Resource        resource.robot 


*** Variables ***
${MALFORM_TOKEN}=   XXXX.YYYY.ZZZZ


*** Test Cases ***
Malformed Token So Get User Status Fail
    Given Get Malformed Token
    When Get User Status
    Then Body Message Is "Provide a valid auth token." 
    And Body Status Is "fail"
    And Status Code Is 401

Malformed Token So Logout Fail
    Given Get Malformed Token
    When Get User Status
    Then Body Message Is "Provide a valid auth token." 
    And Body Status Is "fail"
    And Status Code Is 401

Already Logout So Get User Status Fail
    Given Valid Login
    And Get Token
    And Logout
    When Get User Status
    Then Body Message Is "Token blacklisted. Please log in again."
    And Body Status Is "fail"
    And Status Code Is 401

Already Logout So Logout Fail
    Given Valid Login
    And Get Token
    And Logout
    When Logout
    Then Body Message Is "Token blacklisted. Please log in again."
    And Body Status Is "fail"
    And Status Code Is 401

Token Timeout So Get User Status Fail
    Given Valid Login
    And Get Token
    When Sleep  ${TOKEN_TIMEOUT} seconds
    And Get User Status
    Then Body Message Is "Signature expired. Please log in again." 
    And Body Status Is "fail"
    And Status Code Is 401

Token Timeout So Logout Fail
    Given Valid Login
    And Get Token
    When Sleep  ${TOKEN_TIMEOUT} seconds
    And Logout
    Then Body Message Is "Signature expired. Please log in again." 
    And Body Status Is "fail"
    And Status Code Is 401


*** Keywords ***
Get Malformed Token
    ${AUTH_TOKEN}=  Set Variable    ${MALFORM_TOKEN}
