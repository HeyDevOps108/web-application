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
        string(
            name: 'SUBNAMESPACE',
            defaultValue: '',
            description: 'Enter your Subnamespace'
        )
        string(
            name: 'REPLICAS',
            defaultValue: '',
            description: 'Enter your replicas count'
        )
    }

    environment {
        ARTIFACT_NAME    = "${params.ARTIFACT_NAME}"
        ARTIFACT_VERSION = "${params.ARTIFACT_VERSION}"
        SUBNAMESPACE     = "${params.SUBNAMESPACE}"
        REPLICAS         = "${params.REPLICAS}"
    }

    stages {

        stage('Checkout SCM') {
            steps {
                checkout scm
                sh '''
                  chmod +x build.sh
                  chmod +x publish.sh
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
                  ./publish.sh
                '''
            }
        }

        stage ('Deployment on k8s') {
            steps {
                sh '''
                  ./deploy.sh
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