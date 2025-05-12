# Jenkins CI/CD con Docker y Terraform

Este proyecto muestra cómo construir una aplicación Python con PyInstaller usando Jenkins, desplegado mediante Docker y automatizado con Terraform.

## Requisitos previos

- Docker
- Docker Compose
- Terraform
- Git

## 1. Clonar el repositorio

```bash
git clone https://github.com/<TU-USUARIO>/simple-python-pyinstaller-app.git
cd simple-python-pyinstaller-app
```

## 2. Construir la imagen personalizada de Jenkins

```bash
docker build -t myjenkins-python docs/
```

> Asegúrate de que el archivo `docs/Dockerfile` instale `python3`, `pip3`, `pytest` y `pyinstaller`, y cree un symlink a `python`:
>
> ```Dockerfile
> RUN ln -s /usr/bin/python3 /usr/bin/python
> RUN apt-get update && \
>     apt-get install -y python3 python3-pip curl && \
>     pip3 install --no-cache-dir pytest pyinstaller
> ```

## 3. Infraestructura con Terraform

Dentro del directorio del proyecto (donde esté tu `main.tf`):

```bash
terraform init
terraform apply -auto-approve
```

Esto creará:

- Una red Docker `jenkins`
- Dos volúmenes Docker para Jenkins y los certificados
- Un contenedor `jenkins-docker` con Docker-in-Docker
- Un contenedor `jenkins-blueocean` con tu imagen personalizada `myjenkins-python`

## 4. Acceder a Jenkins

Abre tu navegador en:

```
http://localhost:8080
```

Usuario: `admin`
Contraseña: la encontrarás en:

```bash
docker exec -it jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword
```

## 5. Configurar el pipeline en Jenkins

1. Crea un nuevo ítem → tipo "Pipeline"
2. Ponle un nombre, por ejemplo: `simple-python-pyinstaller-app`
3. En la configuración, selecciona:
    - **Pipeline → Definition**: `Pipeline script from SCM`
    - **SCM**: `Git`
    - **Repository URL**: `https://github.com/<TU-USUARIO>/simple-python-pyinstaller-app.git`
    - Branch: `main`
4. Guarda y ejecuta "Build Now"

## 6. Jenkinsfile

Este archivo ya debe estar en la raíz del repositorio (`Jenkinsfile`) y contiene las etapas:

```groovy
pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py'
                stash(name: 'compiled-results', includes: 'sources/*.py*')
            }
        }
        stage('Test') {
            steps {
                sh 'py.test --junit-xml test-reports/results.xml sources/test_calc.py'
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        stage('Deliver') {
            steps {
                sh 'pyinstaller --onefile sources/add2vals.py'
            }
            post {
                success {
                    archiveArtifacts 'dist/add2vals'
                }
            }
        }
    }
}
```

## 7. Probar el artefacto generado

1. Ve a la sección **Artifacts** en Jenkins tras una build exitosa
2. Descarga el ejecutable `add2vals`
3. Dale permisos de ejecución y pruébalo:

```bash
chmod +x add2vals
./add2vals
```

## 8. Limpieza del entorno

Para detener y eliminar los contenedores:

```bash
terraform destroy -auto-approve
```

---
