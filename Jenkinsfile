pipeline {
    agent any
    stages {
        stage('Connect to Target Host') {
            stage('Deploy with Ansible') {
            steps {
                script {
                    ansiblePlaybook(
                        credentialsId: 'jenkins',
                        playbook: '/var/lib/jenkins/workspace/pipeline/deploy.yml',
                        inventory: '/var/lib/jenkins/workspace/pipeline/inventory.ini'
                    )
                }
            }
        }
    }
}