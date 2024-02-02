pipeline {
    agent any
    stages {
        stage('Connect to Target Host') {
            steps {
                script {
                    sshagent(credentials: ['jenkins']) {
                        sh 'ssh jenkins@34.116.237.21 touch /home/jenkins/TEST.txt'
                    }
                }
            }
        }
    }
}