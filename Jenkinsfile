pipeline {
    agent any
    environment {
        DOCKER_USERNAME = "${credentials(docker-token).username}"
        DOCKER_PASSWORD = "${credentials(docker-token).password}"
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
                        extras: "-e DOCKER_USERNAME=${DOCKER_USERNAME} -e DOCKER_PASSWORD=${DOCKER_PASSWORD}"
                    )
                }
            }
        }
    }
}