pipeline {
    agent none

    stages {
        stage('Create instance build and stage') {
            agent{label 'master'}
            steps {
                echo 'Step one - Create instance build and stage using Terraform'
                sh 'git clone '
                sh '/home/jenkins/'
                sh 'terraform init'
                sh 'terraform apply'
            }
        }
    }
}