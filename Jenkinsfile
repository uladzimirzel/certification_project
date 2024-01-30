pipeline {
    agent none
    stages {
        stage ('Git clone repository') {
            agent {label 'master'}
            steps {
                sh 'rm -rf /var/lib/jenkins/workspace/pipeline/terraform/main.tf'
                sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git'
                sh 'cd /var/lib/jenkins/workspace/pipeline/terraform/'
                sh 'sudo terraform init'
            }
        }
    }
}