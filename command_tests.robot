*** Settings ***
Library           Process
Library           HttpClientLibrary.py
Suite Setup       Start FastAPI Server
Suite Teardown    Stop FastAPI Server

*** Variables ***
${SERVER_URL}     http://127.0.0.1:8000
${POSITIVE_CMD}   HELLO
${NEGATIVE_CMD}   FOO
${INVALID_CMD}    BAR
@{NEGATIVE_COMMANDS}    FOO    DOO    BAZ

*** Test Cases ***

Connection Validation
    [Tags]    connection
    Send Command    ${POSITIVE_CMD}
    Response Status Should Be    200

Positive Command Returns Expected Response
    [Tags]    positive
    Send Command    ${POSITIVE_CMD}
    Response Status Should Be    200
    ${expected}=    Evaluate    {"response": "Hello, client!"}
    Response Should Contain    ${expected}

Negative Command Returns Error
    [Tags]    negative
    Send Command    ${NEGATIVE_CMD}
    Response Status Should Be    400
    ${expected}=    Evaluate    {"error": "Negative command"}
    Response Should Contain    ${expected}

#Looping through a negative command list, for example.
Negative Commands Return Error
    [Tags]    negative
    FOR    ${cmd}    IN    @{NEGATIVE_COMMANDS}
        Log    Sending command: ${cmd}
        Send Command    ${cmd}
        Response Status Should Be    400
        ${expected}=    Evaluate    {"error": "Negative command"}
        Log    Expecting error: ${expected}
        Response Should Contain    ${expected}
    END

#Command in neither lists. 
Invalid Command Returns Error
    [Tags]    error
    Send Command    ${INVALID_CMD}
    Response Status Should Be    400
    ${expected}=    Evaluate    {"error": "Invalid command"}
    Log    Expecting error: ${expected}
    Response Should Contain    ${expected}

Malformed Request Returns Error
    [Tags]    error
    Malformed Request



*** Keywords ***
Start FastAPI Server
    Start Process    uvicorn    main:app    --reload    shell=True    stdout=server.log    stderr=server.log
    Sleep    2s

Stop FastAPI Server
    Terminate All Processes

Malformed Request
    [Tags]    error
    ${status}=    Evaluate    __import__('requests').post('${SERVER_URL}/command', data='{}').status_code
    Should Be Equal As Integers    ${status}    400
    #Builtin.Log    STATUS: ${status}
    ${json}=    Evaluate    __import__('requests').post('${SERVER_URL}/command', data='{}').json()
    Should Be Equal As Strings    ${json}[error]    Malformed request

