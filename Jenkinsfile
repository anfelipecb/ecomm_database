pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/usr/bin:/bin:${env.PATH}"
        IMAGE_NAME = 'ecomm-database'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Build') {
            steps {
                echo "Validating database configuration..."
                sh 'test -f config/init.sql || (echo "init.sql not found" && exit 1)'
                sh 'test -f Dockerfile || (echo "Dockerfile not found" && exit 1)'
            }
        }

        stage('Test') {
            steps {
                echo "Database service - no unit tests (schema validation could be added)"
            }
        }

        stage('Security Scan') {
            steps {
                echo "Database image - security scan placeholder (Trivy could be used if installed)"
            }
        }

        stage('Container Build') {
            steps {
                script {
                    def gitCommit = env.GIT_COMMIT ? env.GIT_COMMIT.take(7) : 'unknown'
                    env.IMAGE_TAG = "${env.BUILD_NUMBER}-git-${gitCommit}"
                }
                echo "Building Docker image ${IMAGE_NAME}:${env.IMAGE_TAG}"
                sh "docker build -t ${IMAGE_NAME}:${env.IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Container Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: env.DOCKER_CREDENTIALS_ID,
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh 'echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin'
                    sh """
                        docker tag ${IMAGE_NAME}:${env.IMAGE_TAG} \$DOCKERHUB_USER/${IMAGE_NAME}:${env.IMAGE_TAG}
                        docker tag ${IMAGE_NAME}:latest \$DOCKERHUB_USER/${IMAGE_NAME}:latest
                        docker push \$DOCKERHUB_USER/${IMAGE_NAME}:${env.IMAGE_TAG}
                        docker push \$DOCKERHUB_USER/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploy stage - placeholder for Kubernetes deployment (Phase 5)"
                echo "Image: ${IMAGE_NAME}:${env.IMAGE_TAG}"
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}
