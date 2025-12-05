pipeline {
    agent none

    environment {
        ARTIFACT_NAME = 'folio'
        ARTIFACT_VERSION = '1.0.0'
    }

    stages {
        stage ('checkout scm') {
            agent {label 'master'}
            steps {
                checkout scm
                stash includes: 'dist.zip, Dockerfile', name: 'artifact'
                echo "Artifact + Dockerfile stashed" 
            }
        }

        stage ('Build and push on Slave-1') {
            agent {label 'slave1'}
            steps {
                unstash 'artifact'
                sh """
                    docker stop uiapp || true
                    docker rm uiapp || true
                    unzip -o dist.zip
                    docker build -t ${ARTIFACT_NAME}:${ARTIFACT_VERSION} .
                    docker run -d --name ${ARTIFACT_NAME} -p 80:80 ${ARTIFACT_NAME}:${ARTIFACT_VERSION}
                """
                echo "Image built with name: ${ARTIFACT_NAME} and version: ${ARTIFACT_VERSION}"
                echo "Container is up and running on Slave-1"
            }
        }

        stage ('build and push on Slave-2') {
            agent {label 'slave2'}
            steps {
                unstash 'artifact'
                sh """
                    docker stop uiapp || true
                    docker rm uiapp || true
                    unzip -o dist.zip
                    docker build -t ${ARTIFACT_NAME}:${ARTIFACT_VERSION} .
                    docker container run -d --name ${ARTIFACT_NAME} -p 80:80 ${ARTIFACT_NAME}:${ARTIFACT_VERSION}
                """
                echo "Image built with name: ${ARTIFACT_NAME} and version: ${ARTIFACT_VERSION}"
                echo "Container is up and running on Slave-1"
            }
        }
    }
}