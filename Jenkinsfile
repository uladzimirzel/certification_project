pipeline {
    agent any
    stages {
        stage('terr') {
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
                    sh 'ssh-keygen -R 34.116.237.21'
                    sh 'ssh-keygen -R 34.118.105.40'
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