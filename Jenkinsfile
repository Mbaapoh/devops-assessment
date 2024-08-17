pipeline {
    agent any
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
                    // Ensure the build directory exists
                    sh 'mkdir -p build'
                    
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
                    // Use Maven to run tests
                    sh 'mvn test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Print the current working directory and list its contents
                    sh '''
                        # Ensure the build directory exists
                        mkdir -p build
                        
                        # Copy the files to the build directory
                        cp -r pom.xml src target build/
                        
                        # Print the current working directory before building the Docker image
                        echo "Current working directory:"
                        pwd
                        
                        echo "Contents of the current directory:"
                        ls -la
                        
                        # Change to the build directory and list its contents
                        cd build

                        echo "Contents of the build directory:"
                        ls
                        
                        # Build the Docker image using the specified Dockerfile
                        docker build -f Dockerfile-java -t maviance-devops-app:latest .

                        # Optionally, check container images
                        docker images
                    '''

                    // Log in to Docker Hub
                    withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/']) {
                    // Tag and push the Docker image to Docker Hub
                    sh 'docker tag maviance-devops-app:latest mbaapoh/maviance-devops-app:latest'
                    sh 'docker push mbaapoh/maviance-devops-app:latest'
                }
            }
        }

        stage('Run Maven Compile') {
            steps {
                script {
                    // Run the Docker container, which automatically runs `mvn compile` because of the CMD instruction
                    echo 'Testing container if it works'
                    sh 'docker run --rm maviance-devops-app:latest'
                }
            }
        }
    }
}
