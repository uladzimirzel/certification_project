pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('/var/lib/jenkins/peppy-web-405812-49c67ecba27f.json')
    }
    stages {
        stage ('Git clone repository') {
            steps {
                sh 'sudo rm -rf /var/lib/jenkins/workspace/pipeline/certification_project/'
                sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git /var/lib/jenkins/workspace/pipeline/certification_project'
                sh 'cd /var/lib/jenkins/workspace/pipeline/certification_project/terraform'
            }
        }
        stage ('Init terraform, create instance') {
            steps {
                dir('terraform') {
                    sh 'sudo terraform destroy -auto-approve'
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                }
            }
        }
    }
}