pipeline {
    agent any
    stages {
        stage ('Init terraform, create instance') {
            steps {
                dir('terraform') {
                    sh 'sudo terraform destroy -auto-approve'
                    sh 'sudo terraform init'
                    sh 'sudo terraform apply -auto-approve'
                }
            }
        }
        stage ('Build and Deploy') {
            steps {
                script {
                    def buildInstanceIP = sh (
                        script: 'terraform output -json build_instance_ip',
                        returnStdout: true
                    ).trim()
                    def stageInstanceIP = sh (
                        script: 'terraform output -json stage_instance_ip',
                        returnStdout: true
                    ).trim()
                       // Запускаем playbook с передачей IP-адресов
                    ansiblePlaybook playbook: 'deploy.yml', extraVars: [
                        build_instance_ip: buildInstanceIP,
                        stage_instance_ip: stageInstanceIP
                    ]
                }
            }
        }
    }
}