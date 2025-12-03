pipeline {
    agent { label 'master' }

    environment {
        WEBROOT = '/var/www/html'
    }

    stages {
        stage ('checkout git project') {
            agent { label 'master' }
            steps {
                checkout scm
                stash includes: 'dist.zip', name: 'artifact'
            }
        }

        stage ('Deployment on Slave-1') {
            agent {label 'Slave-1'}
            steps {
                unstash 'artifact'
                sh """
                    sudo rm -rf ${WEBROOT}/*
                    sudo unzip -o dist.zip
                    sudo cp -r dist/Folio/* ${WEBROOT}/
                    sudo systemctl restart nginx
                """
            }
        }

        stage ('Deployment on Slave-2') {
            agent {label 'Slave-2'}
            steps {
                unstash 'artifact'
                sh """
                    sudo rm -rf ${WEBROOT}/*
                    sudo unzip dist.zip 
                    sudo cp -r dist/Folio/* ${WEBROOT}/
                    sudo systemctl restart nginx
                """
            }
        }
    }
}