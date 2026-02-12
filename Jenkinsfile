pipeline {
    agent any

    environment {
        IMAGE_NAME = "python-demo"
        CONTAINER_NAME = "python-demo-container"
    }

    stages {

        stage('Clone') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kakashi734/python-application']])
            }
        }

        stage('Install Dependencies and test') {
            agent {
                docker {
                    image 'python:3.11'
                }
            }
            steps {
                sh 'pip install -r requirements.txt'
                sh 'pytest'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                docker run -d -p 5000:5000 --name $CONTAINER_NAME $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo "Build Successful ✅"
        }
        failure {
            echo "Build Failed ❌"
        }
    }
}
