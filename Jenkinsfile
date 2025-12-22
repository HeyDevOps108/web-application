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
                    unzip -o dist.zip
                    docker build -t folio:1.0.0 .
                    
                '''
            }
        }

    }

}
