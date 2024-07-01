pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'http://192.168.190.133:3000/Hebashaban/InstallApache'
            }
        }
  
        stage('Install Apache') {
            steps {
                script {
                    // Execute Ansible playbook to install Apache
                    sh 'ansible-playbook InstallApache.yml -i inventory'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build --no-cache -t myapp .'
                    // Archive Docker image artifact (if needed)
                    sh 'docker save myapp > myapp.tar'
                    archiveArtifacts artifacts: 'myapp.tar', allowEmptyArchive: true
                }
            }
        }

        stage('Retrieve Users and Send Notification') {
            steps {
                script {
                    def deployGUsers = sh(script: "ssh management@192.168.190.135 'getent group deployG | cut -d: -f4'", returnStdout: true).trim()

                    env.DEPLOYG_USERS = deployGUsers

                    // output of your script
                    def pipelineStatus = "Success" 
                    def date = new Date().format('yyyy-MM-dd HH:mm:ss')
                    def dockerImagePath = "/path/to/image_archive/myapp.tar" 

                    // email body with formatted content
                    def emailBody = """
                        - Pipeline execution status: ${pipelineStatus}
                        - List of users in the \"deployG\" group:
                          ${deployGUsers}
                        - Date and time of the pipeline execution: ${date}
                        - Path to Docker image.tar: ${dockerImagePath}
                    """

                    // Send email using emailext plugin
                    emailext(
                        to: 'enghebashaban1810@gmail.com',
                        subject: "Jenkins Pipeline Status",
                        body: emailBody
                    )
                }
            }
        }
    }
}
