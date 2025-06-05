

## Descripción general
Este repositorio contiene un backend de Flask y un frontend de React. La distribución del directorio es la siguiente:

```
Backend/ - Código API de Flask
frontend/ - Aplicación React
render.yaml - Configuración para Render
```

El backend expone puntos finales REST usando Flask mientras que el frontend se construye con Create React App.

## Configuración local

1. Se requiere
 **Python 3.11** (o compatible). 
2. Instalar dependencias de backend:
    ```bash
   pip install -r Backend/requirements.txt
   ```
3. Configure las siguientes variables de entorno para que la API pueda conectarse a su base de datos SQL:
  `DB_DRIVER`
   - `DB_SERVER`
   - `DB_NAME`
   - `DB_USER`
   - `DB_PW`
4. Ejecute el backend localmente:
   ```bash
   python Backend/run.py
   # o
   gunicorn wsgi:app
   ```
5. En la carpeta `frontend/` instale las dependencias e inicie el servidor de desarrollo:
  ```bash
   npm install
   npm start
   ```

## Implementando en [ Render ]( https://render.com/ )

1. Create a **Web Service** from this repository (do not set a subdirectory).
   Si se establece `Backend/` como raíz del servicio, Render omitirá la compilación del Dockerfile y aparecerá el error de `gunicorn` faltante.
2. Render detectará automáticamente `render.yaml` y construirá la imagen Docker con `env: docker`; no necesita definir un comando de compilación.
3. No se necesita un comando de compilación para el backend. En `render.yaml` defina:
   ```bash
   startCommand: gunicorn wsgi:app
   ```
4. Configure las mismas variables de entorno de base de datos ( `DB_DRIVER` , `DB_SERVER` , `DB_NAME` , `DB_USER` , `DB_PW` ) en Render.
5. Cree un servicio de **Sitio estático** para la carpeta `frontend/` con el comando de compilación:
   ```bash
   npm install && npm run build
   ```
6. Defina `REACT_APP_API_URL` en Render para que el frontend conozca la URL del backend.



## Environment Variables

- `REACT_APP_API_URL` - Base URL for the backend API. If not defined, the frontend defaults to `http://127.0.0.1:5000/api`.

### Render settings

When deploying on [Render](https://render.com) add `REACT_APP_API_URL` in the **Environment** section of your Render service. Set it to the publicly accessible URL of your backend (e.g. `https://myapp.onrender.com/api`).

# cocode

This repository contains a Flask backend and a React frontend.

## Deployment on Render

`render.yaml` in the repository root defines both services so Render can automatically set them up:

### Backend web service
- **Build:** Render automatically uses `render.yaml` and the included `Dockerfile` to build the service (`env: docker`); no separate build command is required.
```yaml
startCommand: gunicorn wsgi:app
```
- **Environment variables:** `DB_DRIVER`, `DB_SERVER`, `DB_NAME`, `DB_USER`, `DB_PW`

Create a new **Web Service** from this repo in Render and set the values for the variables above to connect to your database. Setting the service root to `Backend/` bypasses the Docker build and results in a `gunicorn` not found error.

### Frontend static site
- **Build:** `npm install && npm run build`
- **Publish directory:** `frontend/build`

Render will automatically deploy the static site defined in `render.yaml`.
