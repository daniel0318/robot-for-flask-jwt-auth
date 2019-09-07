*** Settings ***
Documentation   A practice in robotframework on token-authentication login API
...             test suites include valid_api, invalid_login, token_timeout
...             using gherkin style on top level
...             Reference:
...                 login API: github.com/realpython/flask-jwt-auth.git
...                 REST library in robot: github.com/asyrjasalo/RESTinstance.git
...
Library         REST    http://localhost:5000


*** Variables ***
${NEW_EMAIL}            daniel@gmail.com
${NEW_PASSWORD}         leinad
${VALID_EMAIL}          joe@gmail.com
${VALID_PASSWORD}       123456
${TOKEN_TIMEOUT}        6
${TOKEN_LEGAL_TIME}     4


*** Keywords ***
# Basic API
Register with ${email} and ${password}
    POST        /auth/register  { "email": "${email}", "password": "${password}" }

Login with ${email} and ${password}
    ${RES}=     POST                /auth/login     { "email": "${email}", "password": "${password}" }
    Set Test Variable   ${RES}

Get Token
    ${AUTH_TOKEN}=  Set Variable    ${RES}[body][auth_token]
    Set Test Variable   ${AUTH_TOKEN}

Get User Status
    GET         /auth/status            headers={ "Authorization": "Bearer ${AUTH_TOKEN}"}

Logout
    POST        /auth/logout            headers={ "Authorization": "Bearer ${AUTH_TOKEN}"}

# Medium Level Keyword
Valid Login
    Login with ${VALID_EMAIL} and ${VALID_PASSWORD}

# Response Checking Format
Body Message Is "${message}"
    STRING  response body message   ${message}

Body Status Is "${status_str}"
    STRING  response body status    ${status_str}

Status Code Is ${code} 
    INTEGER     response status     ${code}

Match Email("${email}") from User Status
    STRING  response body data email    ${email}
