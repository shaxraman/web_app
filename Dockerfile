FROM python:3.9-alpine@sha256:296085612121b9d28f252ad472cc5ecfbbb5e46702abc47eb85ffd2d388c98f4

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]