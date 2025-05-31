"""from app import create_app # Importamos la función que crea nuestra aplicación Flask
from app.models import test_connection  # Importamos la función de prueba

app = create_app()  # Creamos una instancia de la aplicación Flask

# Probar conexión antes de iniciar el servidor
test_connection()

if __name__ == "__main__": # Verificamos que este archivo es el que se está ejecutando directamente

    app.run(debug=True) # Levantamos el servidor con Flask en modo debug

"""
import os
from app import create_app

app = create_app()

@app.route('/')
def home():
    return 'Hola desde Flask en Render!'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))

    
























