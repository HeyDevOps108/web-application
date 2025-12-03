pipeline {
    agent none   // do NOT force master at pipeline level

    environment {
        WEBROOT = '/var/www/html'
    }

    stages {

        stage ('Checkout & Stash on Master') {
            agent { label 'master' }
            steps {
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
            }
        }
    }
}
