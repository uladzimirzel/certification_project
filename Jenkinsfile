pipeline {
    agent any
    stages {
        stage ('Init terraform, create instance') {
            steps {
                dir('terraform') {
                    sh 'sudo terraform destroy -auto-approve'
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                }
            }
        }
        stage ('Build and Deploy') {
            steps {
                dir('/var/lib/jenkins/workspace/pipeline') {
                    script {
                        ansiblePlaybook playbook: 'deploy.yml'
                }
            }
        }
    }
}
}