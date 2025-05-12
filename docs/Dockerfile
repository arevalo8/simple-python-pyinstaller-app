FROM jenkins/jenkins:lts

USER root

# Instalar utilidades necesarias
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    lsb-release \
    git \
    && apt-get clean

# Instalar pytest globalmente (con override del entorno gestionado)
RUN pip3 install --break-system-packages --no-cache-dir pytest

# Instalar plugin CLI de Jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"

USER jenkins

