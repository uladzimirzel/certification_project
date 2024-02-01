pipeline {
    agent any
    stages {
        stage ('Init terraform, create instance') {
            steps {
                dir('terraform') {
                    
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                }
            }
        }
        stage ('Build and Deploy') {
            steps {
                dir('certification_project') {
                    script {
                        ansiblePlaybook playbook: 'deploy.yml'
                }
            }
        }
    }
}
}