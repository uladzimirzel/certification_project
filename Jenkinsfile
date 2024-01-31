pipeline {
    agent none
    stages {
        stage ('Git clone repository') {
            agent {label 'master'}
            steps {
                sh 'sudo rm -rf /var/lib/jenkins/workspace/pipeline/certification_project/'
                sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git /var/lib/jenkins/workspace/pipeline/'
                sh 'cd /var/lib/jenkins/workspace/pipeline/certification_project/terraform/'
                sh 'sudo terraform init'
            }
        }
    }
}