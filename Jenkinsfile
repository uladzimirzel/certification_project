pipeline {
    agent any
    stages {
        stage('terr') {
            steps {
                dir('terraform') {
                    sh 'terraform destroy -auto-approve'
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
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