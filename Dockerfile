FROM jenkins/jenkins:latest

USER root

# Instala Docker dentro del contenedor
RUN apt-get update && apt-get install -y docker.io

# Cambia el usuario de nuevo a jenkins
USER jenkins

# Instala Python dentro del contenedor
RUN apt-get update && apt-get install -y python3 python3-pip

# Copia los archivos de tu proyecto al contenedor
COPY . /app

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias de tu proyecto si es necesario
# RUN pip install -r requirements.txt
