pipeline {
    agent { label 'master' }

    parameters {
        booleanParam(
            name: 'UPLOAD_ARTIFACTS',
            defaultValue: false,
            description: 'Upload dist.zip to Nexus (only for new artifacts)'
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
                        http://localhost:8081/repository/opsmatrix-web-artifacts/${ARTIFACT_NAME}/${ARTIFACT_VERSION}/dist.zip
                    '''
                }
            }
        }

        stage('Build Image') {
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