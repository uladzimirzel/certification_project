pipeline {
    agent any
    stages {
        stage('Create instance') {
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
                    sh 'ssh-keygen -f "/var/lib/jenkins/.ssh/known_hosts" -R "34.116.237.21"'
                    sh 'ssh-keygen -f "/var/lib/jenkins/.ssh/known_hosts" -R "34.118.105.40"'
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