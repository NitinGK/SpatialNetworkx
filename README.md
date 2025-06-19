# SpatialNetworksTest

**Assignment:

Develop automated test cases in Python using the Robot Framework for a simple client-server interaction.

Scenario: 

You are tasked with testing a TCP/IP-based client-server application.
The server responds to predefined commands with corresponding messages. 
The client sends command strings and receives the response.

Task: 

Develop a test suite using the Robot Framework that performs the following:

1. Connection Validation: 

   Ensure the client can connect to the server and confirm that the server is accepting connections.

2. Positive Test Case: 

   - Send a valid command (e.g., `HELLO`) 

   - Validate the server returns the expected response (e.g., `"Hello, client!"`)

3. Negative Test Case: 

   - Send a known invalid command (e.g., `FOO`) 

   - Confirm that the server returns a defined error message or rejection (e.g., `"Invalid command"`)

4. Error Test Case: 

   - Send a malformed or empty request (e.g., a blank string or corrupted input) 

   - Ensure the server handles it gracefully with an appropriate error or failure response.


Technical Requirements:

- Test suite should be implemented using Robot Framework.

- Custom Python keywords are encouraged to wrap client-side socket interaction.

- Test organization should use Setup/Teardown, Tags, and Variables where appropriate.

- Reuse of logic across test cases is a bonus.**

## Assumptions

- The server is a FastAPI HTTP server, not a raw socket server.
- Requests and Responses will be JSON Payload. 
- Commands are sent via HTTP POST to `/command` with a JSON payload, e.g., `{ "command": "HELLO" }`.
- The server responds with JSON, ex- "Hello, client!" or "Invalid command" for invalid ones, with suitable error code 200/400.
- Malformed/empty requests return  with 400.
- Robot framework tests use a custom Python library to wrap HTTP client logic.

## Project Structure

- `main.py` — FastAPI server implementation
- `HttpClientLibrary.py` — Custom library for robot framework HTTP keywords
- `command_tests.robot` — Robot Framework test suite
- `requirements.txt` — Python dependencies for setup
- `README.md` — Project overview and setup





##Further Scope-
- Input Validation-  null value, empty string, wrong type, whitespace etc.
- Exception Handling testcases- Huge payload, unexpected fields, server not running etc.
- Data driven testing with lists of +ve and -ve commands.
- Security testing eg- https, authentication/authorisation, malicious payloads, xss etc.
- CI/CD- automated runs on code push with github actions, reporting. 