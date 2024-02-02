pipeline {
    agent any
    stages {
        stage('Create instance') {
            steps {
                dir('terraform') {
                    sh 'sudo terraform destroy -auto-approve'
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                }
            }
        }
        stage('Deploy with Ansible') {
            steps {
                script {
                    sh 'ssh-keygen -f "/root/.ssh/known_hosts" -R "34.118.105.40"'
                    sh 'ssh-keygen -f "/root/.ssh/known_hosts" -R "34.116.237.21"'
                    ansiblePlaybook(
                        credentialsId: 'google_key',
                        playbook: '/var/lib/jenkins/workspace/pipeline/deploy.yml',
                        inventory: '/var/lib/jenkins/workspace/pipeline/inventory.ini'
                    )
                }
            }
        }
    }
}