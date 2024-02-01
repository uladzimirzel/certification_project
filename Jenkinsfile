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
                    def build_instance = sh(script: "terraform output -json build_node_ip | jq -r '.value'", returnStdout: true).trim()
                    def stage_instance = sh(script: "terraform output -json app_node_ip | jq -r '.value'", returnStdout: true).trim()
                    env.BUILD_INSTANCE = build_instance
                    env.STAGE_INSTANCE = stage_instance
                    dir('/var/lib/jenkins/workspace/pipeline') {
                        sh 'ansible-playbook -i \"${BUILD_INSTANCE},${STAGE_INSTANCE}\" deploy.yml'
                    }
                }
            }
        }
    }
}
