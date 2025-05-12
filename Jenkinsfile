pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker { image 'python:3' }
            }
            steps {
                sh 'python -m py_compile sources/add2vals.py sources/calc.py'
                stash(name: 'compiled-results', includes: 'sources/*.py*')
            }
        }
        stage('Test') {
            agent {
                docker { image 'python:3' }
            }
            steps {
                sh '''
                    pip install pytest
                    mkdir -p test-reports
                    pytest --junit-xml=test-reports/results.xml sources/test_calc.py
                '''
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
        stage('Deliver') {
            agent {
                docker { image 'cdrx/pyinstaller-linux:python3' }
            }
            steps {
                unstash 'compiled-results'
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

