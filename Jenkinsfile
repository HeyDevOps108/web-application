pipeline {
    agent none

    environment {
        ARTIFACT_NAME = 'folio'
        ARTIFACT_VERSION = '1.0.0'
    }

    stages {

        stage('Checkout SCM') {
            agent any
            steps {
                checkout scm
                stash includes: 'dist.zip, Dockerfile', name: 'artifact'
                echo "Artifact stashed"
            }
        }

        stage('Deploy on app-server-1') {
            agent { label 'app-server-1' }
            steps {
                unstash 'artifact'
                sh '''
                    docker rm -f folio || true
                    unzip -o dist.zip
                    docker build -t folio:1.0.0 .
                    docker run -d \
                      --name folio \
                      --restart unless-stopped \
                      -p 9200:80 \
                      folio:1.0.0
                '''
            }
        }

        stage('Deploy on app-server-2') {
            agent { label 'app-server-2' }
            steps {
                unstash 'artifact'
                sh '''
                    docker rm -f folio || true
                    unzip -o dist.zip
                    docker build -t folio:1.0.0 .
                    docker run -d \
                      --name folio \
                      --restart unless-stopped \
                      -p 9300:80 \
                      folio:1.0.0
                '''
            }
        }

        stage('Deploy on app-server-3') {
            agent { label 'app-server-3' }
            steps {
                unstash 'artifact'
                sh '''
                    docker rm -f folio || true
                    unzip -o dist.zip
                    docker build -t folio:1.0.0 .
                    docker run -d \
                      --name folio \
                      --restart unless-stopped \
                      -p 9400:80 \
                      folio:1.0.0
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
