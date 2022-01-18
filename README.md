# Simple web app on fastApi

## Run

### Manual

#### Install requirements

```bash
pip3 install -r requirements.txt
```

#### Run app in test mode with reload

```bash
uvicorn app.main:app --reload       
```

#### Run app in stage mode with reload

```bash
uvicorn app.main:app --host 0.0.0.0 --port 8080   
```
