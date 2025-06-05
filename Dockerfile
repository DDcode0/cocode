FROM python:3.11-slim

# Instala msodbcsql18 y herramientas necesarias
RUN apt-get update \
    && apt-get install -y curl gnupg lsb-release unixodbc-dev \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && DISTRO=$(lsb_release -cs) \
    && curl -sSL https://packages.microsoft.com/config/debian/$DISTRO/prod.list \
       > /etc/apt/sources.list.d/mssql-release.list \
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
