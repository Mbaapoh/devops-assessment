pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/master']], // Specify the master branch
                          userRemoteConfigs: [[url: 'https://github.com/maviance/devops-assessment.git']]
                ])
            }
        }
        stage('Build') {
            
             agent {
                docker {
                    image 'maven:3.9.8-eclipse-temurin-11-alpine'
                    reuseNode true // Reuse the same Docker container for subsequent stages
                }
            }
            steps {
                script {
                    // Use Maven to compile the project
                    sh 'mvn compile'
                }
            }
        }

        stage('Test') {
            
             agent {
                docker {
                    image 'maven:3.9.8-eclipse-temurin-11-alpine'
                    reuseNode true // Reuse the same Docker container for subsequent stages
                }
            }
            steps {
                script {
                    // Use Maven to compile the project
                    sh 'mvn test'
                }
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    // sh 'docker build -t my-app:latest .'

                     // Print the current working directory before building the Docker image
                    sh '''
                        echo "Print the current working directory before building the Docker image"
                        pwd
                    
                    '''
                }
            }
        }

    }
}
