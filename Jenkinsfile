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
        booleanParam(name: 'Destroy', defaultValue: 'false', description: 'What is Destroy?')
        booleanParam(name: 'Create', defaultValue: 'false', description: 'What is Create?')
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
                    terraform init --backend-config=${params.environment}/backend.tf -reconfigure
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

            
            
        stage('Apply') {
            when{
                expression{
                    params.Create
                }
            }
            steps {
                sh """
                    cd terraform
                    terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.VERSION}" -auto-approve
                """
            }
        }
        stage('Destroy') {
            when{
                expression{
                    params.Destroy
                }
            }
            steps {
                sh """
                    cd terraform
                    terraform destroy -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.VERSION}" -auto-approve
                """
            }
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
