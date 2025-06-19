from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from pydantic import BaseModel

app = FastAPI()

# command categories for flexibility
POSITIVE_COMMANDS = {
    "HELLO": "Hello, client!",
}
NEGATIVE_COMMANDS = [
    "FOO", "DOO", "BAZ",
]

class CommandRequest(BaseModel):
    command: str

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    return JSONResponse(
        status_code=400,
        content={"error": "Malformed request"}
    )

@app.post("/command")
async def handle_command(payload: CommandRequest):
    command = payload.command.strip().upper()

    if not command:
        return JSONResponse(status_code=400, content={"error": "Malformed request"})

    if command in POSITIVE_COMMANDS:
        return {"response": POSITIVE_COMMANDS[command]}
    elif command in NEGATIVE_COMMANDS:
        return JSONResponse(status_code=400, content={"error": "Negative command"})
    else:
        return JSONResponse(status_code=400, content={"error": "Invalid command"})
