pipeline {
    agent any
    stages {
       stage('Checkout') {
            steps {
                deleteDir() // Deletes the workspace before checking out the code
                checkout([$class: 'GitSCM',
                        branches: [[name: '*/master']], // Specify the master branch
                        userRemoteConfigs: [[url: 'https://github.com/Mbaapoh/devops-assessment.git']],
                        extensions: [[$class: 'CleanBeforeCheckout'], [$class: 'PruneStaleBranch'], [$class: 'CloneOption', noTags: false, shallow: false]]])
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
                        # Copy the files to the build directory
                        cp -r pom.xml src target build/
                        
                        # Print the current working directory before building the Docker image
                        echo "Current working directory:"
                        pwd
                        
                        echo "Contents of the current directory:"
                        ls -la
                        
                        # Change to the build directory and list its contents
                        cd build

                        # Build the Docker image
                        docker build -t maviance-devops-app:latest .

                        echo "Contents of the build directory:"
                        ls
                        docker ps
                    
                    '''
                }
            }
        }

    }
}
