@Library('ecomm-shared-lib') _

pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/usr/bin:/bin:${env.PATH}"
        IMAGE_NAME = 'ecomm-database'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Detect Environment') {
            steps {
                script { detectEnvironment() }
            }
        }

        stage('Build') {
            steps {
                echo "Validating database configuration..."
                sh 'test -f config/init.sql || (echo "init.sql not found" && exit 1)'
                sh 'test -f Dockerfile || (echo "Dockerfile not found" && exit 1)'
            }
        }

        stage('Test') {
            steps {
                echo "Database service - no unit tests"
            }
        }

        stage('Security Scan') {
            steps {
                echo "Database image - security scan placeholder"
            }
        }

        stage('Container Build & Push') {
            when {
                expression { env.PIPELINE_ENV != 'build' }
            }
            steps {
                buildAndPushDockerImage(env.IMAGE_NAME, env.DOCKER_CREDENTIALS_ID)
            }
        }

        stage('Approve Production Deploy') {
            when {
                expression { env.PIPELINE_ENV == 'prod' }
            }
            steps {
                approveProdDeploy()
            }
        }

        stage('Deploy') {
            when {
                expression { env.PIPELINE_ENV != 'build' }
            }
            steps {
                script {
                    deployToK8s(
                        'ecomm-database',
                        'postgres',
                        ['namespace.yaml', 'secret.yaml', 'configmap.yaml', 'pv-database.yaml', 'deployment.yaml', 'service.yaml']
                    )
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}
