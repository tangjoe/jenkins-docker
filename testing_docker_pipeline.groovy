pipeline {
    environment {
        registry= "tangjoe88/hello"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    agent any

    stages {
        stage('Clone from Git') {
            steps {
                git 'https://github.com/tangjoe/hello-docker.git'
            }
        }
        stage('Build image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy image to dockerhub') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Remove unused local image') {
            steps {
              sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
