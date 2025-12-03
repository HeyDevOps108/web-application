pipeline {
    agent any 

    environment {
        WEBROOT = '/var/www/html'
    }

    stages {
        stage ('Checkout SCM') {
            steps {
            checkout scm 
            }
        }

        stage ('Deploy to Nginx') {
            steps {
              sh '''
                sudo rm -rf ${WEBROOT}/*
                sudo cp * ${WEBROOT}/
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