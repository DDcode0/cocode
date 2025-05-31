#!/usr/bin/env bash
set -euxo pipefail
export DEBIAN_FRONTEND=noninteractive   # evita prompts interactivos

# 1️⃣   Arreglar el bug del directorio de listas
sudo rm -rf /var/lib/apt/lists          || true
sudo mkdir -p /var/lib/apt/lists/partial

# 2️⃣   Refrescar índices
sudo apt-get update -y

# 3️⃣   Dependencias básicas
sudo apt-get install -y curl gnupg lsb-release unixodbc-dev

# 4️⃣   Clave y repo de Microsoft ODBC Driver 18
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
DISTRO=$(lsb_release -cs)
curl -sSL https://packages.microsoft.com/config/debian/"$DISTRO"/prod.list \
  | sudo tee /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update -y
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18

echo "✅  ODBC Driver 18 instalado."
