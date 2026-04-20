pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKERHUB_USERNAME    = "30727"
        DEV_IMAGE             = "${DOCKERHUB_USERNAME}/dev:latest"
        PROD_IMAGE            = "${DOCKERHUB_USERNAME}/prod:latest"
        LOCAL_IMAGE           = "ecommerce-app:latest"
        CONTAINER_NAME        = "ecommerce-container"
    }

    triggers {
        githubPush()
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out branch: ${env.BRANCH_NAME}"
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'chmod +x build.sh && ./build.sh'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push to DEV Repo') {
            when { branch 'dev' }
            steps {
                sh "docker tag $LOCAL_IMAGE $DEV_IMAGE"
                sh "docker push $DEV_IMAGE"
            }
        }

        stage('Push to PROD Repo') {
            when { branch 'main' }   // <-- FIXED
            steps {
                sh "docker tag $LOCAL_IMAGE $PROD_IMAGE"
                sh "docker push $PROD_IMAGE"
            }
        }

        stage('Deploy') {
            steps {
                sh 'chmod +x deploy.sh && ./deploy.sh'
            }
        }
    }

    post {
        success { echo 'Pipeline SUCCESS!' }
        failure { echo 'Pipeline FAILED!' }
        always  {
            sh 'docker system prune -af || true'
            sh 'docker logout || true'
        }
    }
}
