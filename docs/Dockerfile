# Utiliza una imagen base de Jenkins LTS (Long Term Support)
FROM jenkins/jenkins:lts


# Instala herramientas adicionales y plugins necesarios
USER root
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    git \
    && apt-get clean

# Instala plugins de Jenkins usando el archivo de plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Configura opciones adicionales de Jenkins
# Por ejemplo, si necesitas configurar alguna opción de seguridad o permisos
#COPY config.xml /var/jenkins_home/config.xml

# Establece el usuario de Jenkins nuevamente
USER jenkins
