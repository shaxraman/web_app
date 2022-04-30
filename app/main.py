from fastapi import FastAPI
from fastapi.responses import HTMLResponse
import socket


app = FastAPI()


@app.get("/", response_class=HTMLResponse)
async def read_items():
    return """
    <html>
        <head>
            <title>Some HTML in here</title>
        </head>
        <body>
            <h1>Look ma! HTML!</h1>
        </body>
    </html>
    """


@app.get("/host")
async def host() -> dict:
    """ Print hostname and IP v4 address """
    hostname = socket.gethostname()
    ipv4 = socket.gethostbyname(socket.gethostname())
    return {"hostname": hostname, "ipv4": ipv4}


@app.get("/health")
def health_check() -> dict:
    """ Healthcheck url """
    return {"status": "ok"}
