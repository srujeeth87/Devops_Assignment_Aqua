FROM python:3.11-slim

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir fastapi uvicorn requests

RUN adduser --disabled-password appuser
USER appuser

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]