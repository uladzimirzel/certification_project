pipeline {
    agent any
    stages {
        stage('Create instance') {
            steps {
                dir('terraform') {
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                }
            }
        }
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