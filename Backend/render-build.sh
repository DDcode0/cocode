#!/usr/bin/env bash
# render-build.sh
#!/usr/bin/env bash
set -e   # aborta si algo falla

echo "➜ Instalando ODBC Driver 18 …"
apt-get update -qq

# herramientas básicas
apt-get install -y --no-install-recommends curl gnupg ca-certificates

# clave y repo oficiales de Microsoft
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl -sSL https://packages.microsoft.com/config/debian/12/prod.list \
  | tee /etc/apt/sources.list.d/mssql-release.list

apt-get update -qq
ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev

echo "✓ ODBC instalado"
