FROM python:3.11-slim

# Instala msodbcsql18 y herramientas necesarias
RUN apt-get update \
    && apt-get install -y curl gnupg2 unixodbc-dev \
    && rm -f /etc/apt/sources.list.d/mssql-release.list \
    && mkdir -p /etc/apt/keyrings \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/keyrings/microsoft.gpg \
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/ bookworm main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*



WORKDIR /app

# Instala dependencias de Python
COPY Backend/requirements.txt Backend/requirements.txt
RUN pip install --no-cache-dir -r Backend/requirements.txt

# Copia todo el código del backend
COPY Backend/ Backend/

WORKDIR /app/Backend

CMD ["gunicorn", "wsgi:app"]
