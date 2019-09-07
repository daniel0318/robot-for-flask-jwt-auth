*** Settings ***
Documentation   Test timeout functionality
Resource        resource.robot 


*** Test Cases ***
Should Get User Status Before Timeout 
    Given Valid Login
    And Get Token
    When Sleep  ${TOKEN_LEGAL_TIME} seconds
    And Get User Status
    Then Match Email("${VALID_EMAIL}") from User Status
    And Body Status Is "success"
    And Status Code Is 200

Cannot Get User Status Because Of Timeout 
    Given Valid Login
    And Get Token
    When Sleep  ${TOKEN_TIMEOUT} seconds
    And Get User Status
    Then Body Message Is "Signature expired. Please log in again." 
    And Body Status Is "fail"
    And Status Code Is 401

No Need to Logout If Already Timeout
    Given Valid Login
    And Get Token
    When Sleep  ${TOKEN_TIMEOUT} seconds
    And Logout
    Then Body Message Is "Signature expired. Please log in again." 
    And Body Status Is "fail"
    And Status Code Is 401
