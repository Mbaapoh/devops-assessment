pipeline {
    agent any
    environment {
        PUSH_IMAGE = 'true' // Set this to 'true' or 'false' to control image pushing
    }
    stages {
        stage('Checkout') {
            steps {
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
                    sh 'mkdir -p build'
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
                    sh 'mvn test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Ensure the build directory exists
                    sh 'mkdir -p build'
                    
                    // Copy the files to the build directory
                    sh 'cp -r pom.xml src target build/'
                    
                    // Print the current working directory and list its contents
                    sh '''
                        echo "Current working directory:"
                        pwd
                        
                        echo "Contents of the current directory:"
                        ls -la
                        
                        cd build
                        
                        echo "Contents of the build directory:"
                        ls

                        # Build Docker image
                        docker build -f Dockerfile-java -t maviance-devops-app:1.0.0 .

                        # Tag the Docker image
                        docker tag maviance-devops-app:1.0.0 mbaapoh/maviance-devops-app:1.0.0
                    '''
                    
                    
                    // Optionally, check Docker images
                    sh 'docker images'

                    // Push Docker image to Docker Hub if PUSH_IMAGE is true
                    if (env.PUSH_IMAGE == 'true') {
                        withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/']) {
                            sh 'docker push mbaapoh/maviance-devops-app:1.0.0'
                        }
                    }
                }
            }
        }

        stage('Run Maven Compile') {
            steps {
                script {
                    // Run the Docker container to ensure it works correctly
                    sh 'docker run --rm maviance-devops-app:1.0.0'
                }
            }
        }
    }
}
