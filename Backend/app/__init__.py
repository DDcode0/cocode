import os
import logging

from flask import Flask
from flask_cors import CORS

from app.extensions import db
from app.routes import (
    personas_bp,
    derechos_bp,
    cuotas_bp,
    pagos_bp,
    ingresos_bp,
    egresos_bp,
    persona_derecho_bp,
)


def create_app() -> Flask:
    app = Flask(__name__)
    CORS(app, resources={r"/api/*": {"origins": "*"}})

    # ---------- conexión a Azure SQL vía ODBC ----------
    DRIVER = os.getenv("DB_DRIVER", "ODBC Driver 18 for SQL Server")
    SERVER = os.getenv("DB_SERVER", "cocode-server-2025.database.windows.net,1433")
    DATABASE = os.getenv("DB_NAME", "cocode-db")
    USER = os.getenv("DB_USER", "admincocode")
    PASSWORD = os.getenv("DB_PW", "cocode_Gest!ion")

    app.config[
        "SQLALCHEMY_DATABASE_URI"
    ] = (
        f"mssql+pyodbc://{USER}:{PASSWORD}@{SERVER}/{DATABASE}"
        f"?driver={DRIVER.replace(' ', '+')}"
        "&Encrypt=yes&TrustServerCertificate=yes"
    )
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

    # ---------- extensiones ----------
    db.init_app(app)

    # ---------- blueprints ----------
    app.register_blueprint(personas_bp, url_prefix="/api")
    app.register_blueprint(derechos_bp, url_prefix="/api")
    app.register_blueprint(cuotas_bp, url_prefix="/api")
    app.register_blueprint(pagos_bp, url_prefix="/api")
    app.register_blueprint(ingresos_bp, url_prefix="/api")
    app.register_blueprint(egresos_bp, url_prefix="/api")
    app.register_blueprint(persona_derecho_bp, url_prefix="/api")

    # ---------- logging ----------
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=[
            logging.FileHandler("system.log"),
            logging.StreamHandler(),
        ],
    )

    return app
