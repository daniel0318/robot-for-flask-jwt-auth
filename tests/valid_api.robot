*** Settings ***
Documentation   Workflow test suite on 4 API provided by the server
...             Note Register will delete previous email account.
Resource        resource.robot 


*** Test Cases ***
Register A New Account
    Given Delete Account "${NEW_EMAIL}" From DB
    When Register with ${NEW_EMAIL} and ${NEW_PASSWORD}
    Then Body Message Is "Successfully registered."
    And Body Status Is "success"
    And Status Code Is 201

Valid Login
    When Valid Login
    Then Body Message Is "Successfully logged in."
    And Body Status Is "success"
    And Status Code Is 200

Valid Get User Status
    Given Valid Login
    And Get Token
    When Get User Status
    Then Match Email("${VALID_EMAIL}") from User Status
    And Body Status Is "success"
    And Status Code Is 200

Valid Logout
    Given Valid Login
    And Get Token
    When Logout
    Then Body Status Is "success"
    And Status Code Is 200 

