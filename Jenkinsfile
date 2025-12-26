pipeline {
    agent { label 'master' }

    parameters {
        booleanParam(
            name: 'UPLOAD_ARTIFACTS',
            defaultValue: false,
            description: 'Upload dist.zip to Nexus (only for new artifacts)'
        )
        booleanParam(
            name: 'FORCE_BUILD',
            defaultValue: false,
            description: 'True = build || false != build'
        )
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
                  chmod +x push.sh
                  chmod +x deploy.sh
                '''
            }
        }

        stage('Upload Artifact to Nexus') {
            when {
                expression { params.UPLOAD_ARTIFACTS == true }
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'Nexus-Secrets',
                        usernameVariable: 'NEXUS_USER',
                        passwordVariable: 'NEXUS_PASS'
                    )
                ]) {
                    sh '''
                      echo "Uploading dist.zip to Nexus"
                      curl -u ${NEXUS_USER}:${NEXUS_PASS} \
                        --upload-file dist.zip \
                        http://10.0.12.224:8081/repository/opsmatrix-web-artifacts/${ARTIFACT_NAME}/${ARTIFACT_VERSION}/dist.zip
                    '''
                }
            }
        }

        stage('Build Image') {
            when {
                expression { params.FORCE_BUILD != false }
            }
            steps {
                sh '''
                  ./build.sh
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                  ./push.sh
                '''
            }
        }

        stage('Deployment on app-server-1'){
            agent { label 'app-server-1' }
            steps {
                sh '''
                  chmod +x deploy.sh
                  ./deploy.sh
                  echo "Deployment completed on app-server-1"
                '''
            }
        }

        stage('Deployment on app-server-2'){
            agent { label 'app-server-2' }
            steps {
                sh '''
                  chmod +x deploy.sh
                  ./deploy.sh
                  echo "Deployment completed on app-server-2"
                '''
            }
        }

        stage('Deployment on app-server-3'){
            agent { label 'app-server-3' }
            steps{
                sh '''
                  chmod +x deploy.sh
                  ./deploy.sh
                  echo "Deployment completed on app-server-3"
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
    }
}