pipeline {
    agent any 

    environment {
        WEBROOT = '/var/www/html'
        WORKDIR = '/mnt/workspace'
    }

    stages {
        stage ('Checkout SCM') {
            steps {
                dir("${WORKDIR}") {
                    checkout scm
                }
            }
        }

        stage ('Deploy to Nginx') {
            steps {
              sh '''
                cd ${WORKDIR}
                sudo unzip -o dist.zip
                sudo rm -rf ${WEBROOT}/*
                sudo cp -r dist/* ${WEBROOT}/
                sudo chown -R www-data:www-data ${WEBROOT}
              '''  
            }
        }

        stage ('Rstart the Server') {
            steps {
                sh 'sudo systemctl restart nginx'
            }
        }

    }
}