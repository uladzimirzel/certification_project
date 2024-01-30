pipeline {
    agent none
    stages {
        stage ('Create instance') {
            agent {label 'master'}
            steps {
                sh 'rm -rf var/lib/jenkins/workspace/pipeline/certification_project'
                sh 'git clone https://github.com/uladzimirzel/certification_project.git'
                sh 'cd /var/lib/jenkins/workspace/pipeline/certification_project/terraform'
                sh 'terraform destroy'
                sh 'terraform init'
                sh 'terraform apply'
            }
        }
    }
}