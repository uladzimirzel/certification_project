pipeline {
    agent none
    stages {
        stage ('Git clone repository') {
            agent {label 'master'}
            steps {
                sh 'sudo su'
                sh 'rm -rf /var/lib/jenkins/workspace/pipeline/certification_project'
                sh 'git clone https://github.com/uladzimirzel/certification_project.git'
                sh 'cd /var/lib/jenkins/workspace/pipeline/certification_project/terraform'
                sh 'terraform init'
                sh 'terraform apply'
            }
        }
    }
}