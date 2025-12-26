pipeline {
    agent { label 'master' }

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
                sh '''
                  chmod +x build.sh
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