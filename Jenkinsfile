pipeline {
    agent none
    stages {
        stage ('Git clone repository') {
            agent {label 'master'}
            steps {
                sh 'sudo rm -rf /var/lib/jenkins/workspace/pipeline/certification_project/'
                sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git /var/lib/jenkins/workspace/pipeline/certification_project'
                sh 'cd /var/lib/jenkins/workspace/pipeline/certification_project/terraform'
            }
        }
        stage ('Init terraform and create instance') {
            agent {label 'master'}
            steps {
                dir('terraform') {
                    sh 'sudo terraform destroy -auto-approve'
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                }
            }
        }
        stage ('Build docker container') {
            agent {label 'build'}
            steps {
                sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git /var/lib/jenkins/workspace/pipeline/certification_project'
                sh 'sudo ansible-palybook ansible-playbook.yml'
            }
        }
        stage ('Build docker container') {
            agent {label 'build'}
            steps {
                sh 'sudo git clone https://github.com/uladzimirzel/certification_project.git /var/lib/jenkins/workspace/pipeline/certification_project'
                sh 'sudo ansible-palybook ansible-playbook.yml'
            }
        }
    }
}