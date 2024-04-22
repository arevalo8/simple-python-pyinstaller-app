# Usamos la imagen oficial de Jenkins como base
FROM jenkins/jenkins:latest

# Instalamos las herramientas necesarias
USER root
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Configuramos Jenkins con los plugins y configuraciones necesarios
# (Puedes añadir aquí cualquier configuración específica que necesites)

# Cambiamos al usuario Jenkins
USER jenkins
