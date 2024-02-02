pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                withCredentials([googleComputeCredentials(credentialsId: 'jenkins', project: 'peppy-web-405812')]) {

                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                ansiblePlaybook(
                    playbook: '/var/lib/jenkins/workspace/pipeline/deploy.yml',
                    inventory: '/var/lib/jenkins/workspace/pipeline/inventory.ini'
                )
            }
        }
    }
}