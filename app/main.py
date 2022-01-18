from fastapi.responses import HTMLResponse
from fastapi import FastAPI

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


@app.get("/health")
def health_check() -> dict:
    return {"status": "ok"}
