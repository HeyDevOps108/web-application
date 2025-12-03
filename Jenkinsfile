pipeline {
    agent none   // do NOT force master at pipeline level

    environment {
        WEBROOT = '/var/www/html'
        SLACK_CHANNEL = '#all-play-with-devops'
        SLACK_TOKEN = 'slack-correct-token'   // credential ID (Secret Text)
    }

    stages {

        stage ('Checkout & Stash on Master') {
            agent { label 'master' }
            steps {
                script {
                    slackSend tokenCredentialId: env.SLACK_TOKEN,
                              channel: env.SLACK_CHANNEL,
                              color: "good",
                              message: "🚀 Deployment STARTED on MASTER (Build #${env.BUILD_NUMBER})"
                }

                checkout scm
                stash includes: 'dist.zip', name: 'artifact'
                echo "Artifact stashed successfully from MASTER"
            }
        }

        stage ('Deployment on Slave 1') {
            agent { label 'slave1' }
            steps {
                unstash 'artifact'
                sh """
                    sudo rm -rf ${WEBROOT}/*
                    sudo unzip -o dist.zip
                    sudo cp -r dist/Folio/* ${WEBROOT}/
                    sudo systemctl restart nginx
                """
                echo "Deployment completed on SLAVE 1"

                script {
                    slackSend tokenCredentialId: env.SLACK_TOKEN,
                              channel: env.SLACK_CHANNEL,
                              color: "#439FE0",
                              message: "📌 Deployment completed on *SLAVE 1* (Build #${env.BUILD_NUMBER})"
                }
            }
        }

        stage ('Deployment on Slave 2') {
            agent { label 'slave2' }
            steps {
                unstash 'artifact'
                sh """
                    sudo rm -rf ${WEBROOT}/*
                    sudo unzip -o dist.zip
                    sudo cp -r dist/Folio/* ${WEBROOT}/
                    sudo systemctl restart nginx
                """
                echo "Deployment completed on SLAVE 2"

                script {
                    slackSend tokenCredentialId: env.SLACK_TOKEN,
                              channel: env.SLACK_CHANNEL,
                              color: "#439FE0",
                              message: "📌 Deployment completed on *SLAVE 2* (Build #${env.BUILD_NUMBER})"
                }
            }
        }
    }

    post {
        success {
            slackSend tokenCredentialId: env.SLACK_TOKEN,
                      channel: env.SLACK_CHANNEL,
                      color: "good",
                      message: "✅ Deployment SUCCESS — Build #${env.BUILD_NUMBER}"
        }

        failure {
            slackSend tokenCredentialId: env.SLACK_TOKEN,
                      channel: env.SLACK_CHANNEL,
                      color: "danger",
                      message: "❌ Deployment FAILED — Build #${env.BUILD_NUMBER}"
        }

        always {
            slackSend tokenCredentialId: env.SLACK_TOKEN,
                      channel: env.SLACK_CHANNEL,
                      color: "#CCCCCC",
                      message: "🔗 Console Log: <${env.BUILD_URL}console|Click here>"
        }
    }
}