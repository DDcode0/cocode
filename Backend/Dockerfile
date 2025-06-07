# Usa la variante slim basada en Debian 11 (bullseye)
FROM python:3.11-slim-bullseye

# Instala msodbcsql18 y herramientas necesarias
RUN apt-get update \
    && apt-get install -y curl gnupg2 unixodbc-dev \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc \
       | gpg --dearmor -o /etc/apt/trusted.gpg.d/microsoft.gpg \
    && echo "deb [arch=amd64] https://packages.microsoft.com/debian/11/prod bullseye main" \
       > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia e instala dependencias de Python
COPY Backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código del backend
COPY Backend/ .

# Expone el puerto estándar (opcional, si tu app lo necesita)
# EXPOSE 8000

# Arranca la aplicación con Gunicorn
CMD ["gunicorn", "wsgi:app"]
