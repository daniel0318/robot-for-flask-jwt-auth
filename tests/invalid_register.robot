*** Settings ***
Documentation   Test timeout functionality
Resource        resource.robot 


*** Test Cases ***
Duplicate Register
    Given Delete Account "${NEW_EMAIL}" From DB
    And Register with ${NEW_EMAIL} and ${NEW_PASSWORD}
    Then Register with ${NEW_EMAIL} and ${NEW_PASSWORD}
    Then Body Message Is "User already exists. Please Log in."
    And Body Status Is "fail"
    And Status Code Is 202

Login Without Register First
    Given Delete Account "${NEW_EMAIL}" From DB
    When Login with ${NEW_EMAIL} and ${NEW_PASSWORD}
    Then Body Message Is "User does not exist."
    And Body Status Is "fail"
    And Status Code Is 404

