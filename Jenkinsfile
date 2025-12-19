pipeline {
    agent none

    parameters {
        string(
            name: 'TARGET_NODES',
            defaultValue: 'app-server-1,app-server-2',
            description: 'Comma separated Jenkins agent labels'
        )
    }

    stages {

        // STEP 1: Always on master
        stage('Checkout SCM') {
            agent { label 'master' }
            steps {
                checkout scm
                stash includes: 'docker.sh', name: 'artifact'
                echo "Checkout & stash done on master"
            }
        }

        // STEP 2: Dynamic installation on slaves
        stage('Install Docker on Target Nodes') {
            steps {
                script {
                    // Convert comma-separated string into list
                    def nodes = params.TARGET_NODES.split(',').collect { it.trim() }

                    for (nodeLabel in nodes) {
                        stage("Install on ${nodeLabel}") {
                            node(nodeLabel) {
                                unstash 'artifact'
                                sh '''
                                    chmod +x docker.sh
                                    ./docker.sh
                                '''
                            }
                        }
                    }
                }
            }
        }
    }
}
