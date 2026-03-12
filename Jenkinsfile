pipeline {
    agent {
        node {
            label 'agent-1'
        }
    }
    environment {
        packageVersion = ''
        nexusUrl = '172.31.64.75:8081'

    }
    options {
        timeout(time: 1, unit:'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters{
        string(name: 'VERSION', defaultValue: '', description: 'Enter the artifact version to be deployed')
        string(name: 'environment',  defaultValue: 'dev', description: 'Enter the target environment to be deployed')
    }
    stages{
        stage('Print version'){
            steps{
                sh """
                    echo "environment: ${params.environment}
                    echo "version: ${params.VERSION}
                """

            }
            }
        stage('Init'){
            steps{
                sh """
                    cd terraform
                    terraform init --backend-config=/${params.environment}/backend.tf -reconfigure
                """

            }
            }
        stage('Plan'){
            steps{
                sh """
                    cd terraform
                    terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version"=${params.VERSION}
                """

            }
            }

            stage('Install Dependencies'){
                steps{
                    sh """
                        npm install
                    """                

            }
            }
            stage('Build'){
                steps{
                    sh """
                    ls -la
                    zip -q -r catalogue.zip ./* -x ".git" -x ".zip"
                    ls -ltr
                    """
                }
            }
            stage('Publish Artifact') {
            steps {
                 nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: "${nexusUrl}",
                    groupId: 'com.roboshop',
                    version: "${packageVersion}",
                    repository: 'catalogue',
                    credentialsId: 'nexus-auth',
                    artifacts: [
                        [artifactId: 'catalogue',
                        classifier: '',
                        file: 'catalogue.zip',
                        type: 'zip']
                    ]
                )
            }
        }
            stage('Deploy') {
                steps {
                    sh """
                        echo "Hello I am deployment completed to nexus"
                        echo "$GREETING"
                        sleep 20
                        """
                }
            }
          
    }
    // post build
    post {
        always{
            echo 'We Will always Win again!'
            deleteDir()
        }
        failure {
            echo 'failure occured, inform the concerned teams over slack'
        }
        success {
            echo 'Confragulations on success build'
        }
    }
}