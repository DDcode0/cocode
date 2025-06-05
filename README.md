# Cocode Project

## Overview
This repository contains a Flask backend and a React frontend. The directory layout is:

```
Backend/  - Flask API code
frontend/ - React application
```

The backend exposes REST endpoints using Flask while the frontend is built with Create React App.

## Local Setup

1. **Python 3.11** (or compatible) is required.
2. Install backend dependencies:
   ```bash
   pip install -r Backend/requirements.txt
   ```
3. Configure the following environment variables so the API can connect to your SQL database:
   - `DB_DRIVER`
   - `DB_SERVER`
   - `DB_NAME`
   - `DB_USER`
   - `DB_PW`
4. Run the backend locally:
   ```bash
   python Backend/run.py
   # or
   gunicorn wsgi:app
   ```
5. In the `frontend/` folder install dependencies and start the development server:
   ```bash
   npm install
   npm start
   ```

## Deploying on [Render](https://render.com/)

1. Create a **Web Service** pointing to `Backend/`.
2. Use this build command:
   ```bash
   bash render-build.sh && pip install -r requirements.txt
   ```
3. Set the start command to:
   ```bash
   gunicorn wsgi:app
   ```
4. Configure the same DB environment variables (`DB_DRIVER`, `DB_SERVER`, `DB_NAME`, `DB_USER`, `DB_PW`) in Render.
5. Create a **Static Site** service for the `frontend/` folder with the build command:
   ```bash
   npm install && npm run build
   ```
6. Define `REACT_APP_API_URL` in Render so the frontend knows the backend URL.

You can also supply a `render.yaml` file in the repository root to automate this setup.
