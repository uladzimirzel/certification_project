pipeline {
    agent any
    stages {
        stage('Deploy with Ansible') {
            steps {
                script {
                    ansiblePlaybook(
                        credentialsId: 'jenkins-key',
                        playbook: '/var/lib/jenkins/workspace/pipeline/deploy.yml',
                        inventory: '/var/lib/jenkins/workspace/pipeline/inventory.ini'
                    )
                }
            }
        }
    }
}