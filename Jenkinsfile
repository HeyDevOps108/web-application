pipeline {
    agent any

    parameters {
        string(
            name: 'ARTIFACT_NAME',
            defaultValue: '',
            description: 'Enter your application name'
        )
        string(
            name: 'ARTIFACT_VERSION',
            defaultValue: '',
            description: 'Enter your application version'
        )
    }

    environment {
        ARTIFACT_NAME    = "${params.ARTIFACT_NAME}"
        ARTIFACT_VERSION = "${params.ARTIFACT_VERSION}"
    }

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
                sh '''
                  chmod +x build.sh
                  chmod +x publish.sh
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                  ./build.sh
                '''
            }
        }

        stage('Push Image to Dockerhub') {
            steps {
                sh '''
                  ./publish.sh
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully"
        }
        failure {
            echo "Pipeline failed"
        }
        always{
            cleanWs()
        }
    }
}