pipeline {
    agent any
    environment {
        DOCKER_USERNAME = credentials('docker-credentials')
        DOCKER_PASSWORD = credentials('docker-credentials')
    }
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
                    ansiblePlaybook(
                        credentialsId: 'jenkins',
                        playbook: '/var/lib/jenkins/workspace/pipeline/deploy.yml',
                        inventory: '/var/lib/jenkins/workspace/pipeline/inventory.ini',
                        extras: '-e docker-username=${DOCKER_USERNAME} -e docker-password=${DOCKER_PASSWORD}'
                    )
                }
            }
        }
    }
}