FROM python:alpine3.15 
# sha256:affe0faa14e7553fc570beec3864e74b5e36f8c19b2bb49ae8ba79c0e9e7236e

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]