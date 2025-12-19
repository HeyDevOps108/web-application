pipeline {
    agent none

    stages {
        stage ('checkout scm') {
            agent {label 'master'}
            steps {
                checkout scm
                stash includes: 'docker.sh', name: 'artifact'
                echo "Artifact + Dockerfile stashed" 
            }
        }

        stage ('Installation on app-server-1') {
            agent {label 'app-server-1'}
            steps {
                unstash 'artifact'
                sh """
                   chmod 777 docker.sh
                   bash docker.sh
                """

            }
        }

        stage ('Installation on app-server-2') {
            agent {label 'app-server-2'}
            steps {
                unstash 'artifact'
                sh """
                   chmod 777 docker.sh
                   bash docker.sh
                """
            }
        }

        stage ('Installation on app-server-3') {
            agent {label 'app-server-3'}
            steps {
                unstash 'artifact'
                sh """
                   chmod 777 docker.sh
                   bash docker.sh
                """
            }
        }
    }
}