pipeline {
    agent any
    stages {
        stage ('Git clone repository') {
            steps {
                    sh 'sudo rm -rf /var/lib/jenkins/workspace/pipeline/certification_project/'
                    sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git'
            }
        }
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
                script {
                    dir('certification_project') {
                        ansiblePlaybook playbook: 'deploy.yml'
                }
            }
        }
    }
}
}