pipeline {
    agent none
    stages {
        stage ('Create instance') {
            agent {label 'master'}
            steps {
                sh 'cd /var/lib/jenkins/workspace/pipeline/certification_project'
                sh 'rm -rf certification_project'
                sh 'git clone https://github.com/uladzimirzel/certification_project.git'
                sh 'cd /var/lib/jenkins/workspace/pipeline/certification_project/terraform'
                sh 'terraform init'
                sh 'terraform apply'
            }
        }
    }
}