pipeline {
    agent none
    stages {
        stage ('Git clone repository') {
            agent {label 'master'}
            steps {
                sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git'
            }
        }
    }
}