#!/bin/bash


: <<'COMMENT'
This script automates the generation and management of SSH key pairs for a Jenkins container.

Steps:
1. The script first checks if an SSH key pair with the specified name already exists on the host system.
   - If the key pair exists, the user is prompted to choose between overwriting the existing key, using the existing key, or exiting the script.
   - If the key pair does not exist, a new one is generated.

2. The script ensures that the ~/.ssh directory exists on the host system with the correct permissions.

3. The public key is appended to the ~/.ssh/authorized_keys file on the host, enabling passwordless SSH access for the generated key.

4. The .ssh directory is created in the Jenkins container if it doesn't already exist.

5. The generated private and public keys are copied to the Jenkins container's .ssh directory.

6. Appropriate permissions are set for the copied SSH keys within the Jenkins container to ensure secure access.

7. The public key is output for reference, indicating that the process has been completed successfully.

This script is useful for automating the secure setup of SSH keys within a Dockerized Jenkins environment, facilitating secure and passwordless access to the Jenkins container.
COMMENT

# Set variables
KEY_NAME="jenkins-key"
JENKINS_CONTAINER_NAME="jenkins-blueocean"

# Check if the SSH key pair already exists
if [ -f "$KEY_NAME" ]; then
    echo "SSH key pair $KEY_NAME already exists."
    read -p "Do you want to ( (U)se existing key, or (E)xit? [U/E]: " choice
    case "$choice" in
        u|U )
            echo "Using existing key..."
            ;;
        e|E )
            echo "Exiting without changes."
            exit 0
            ;;
        * )
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
else
    echo "Generating SSH key pair..."
    ssh-keygen -t rsa -b 4096 -f $KEY_NAME -N "" -C "jenkins@docker" > /dev/null 2>&1
fi

# Ensure the .ssh directory exists on the host
echo "Ensuring .ssh directory exists on the host..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Append the public key to the authorized_keys file
echo "Copying public key to ~/.ssh/authorized_keys..."
cat ${KEY_NAME}.pub >> ~/.ssh/authorized_keys

# Set appropriate permissions for authorized_keys
chmod 600 ~/.ssh/authorized_keys

echo "SSH key has been added to authorized_keys successfully."

# Ensure the .ssh directory exists in the Jenkins container
echo "Ensuring .ssh directory exists in the Jenkins container..."
docker exec -u root $JENKINS_CONTAINER_NAME mkdir -p /var/jenkins_home/.ssh

# Copy the private and public keys to the Jenkins container
echo "Copying SSH key pair to Jenkins container..."
docker cp $KEY_NAME $JENKINS_CONTAINER_NAME:/var/jenkins_home/.ssh/$KEY_NAME
docker cp $KEY_NAME.pub $JENKINS_CONTAINER_NAME:/var/jenkins_home/.ssh/$KEY_NAME.pub

# Set appropriate permissions for the keys in the Jenkins container
echo "Setting permissions for SSH keys in Jenkins container..."
docker exec -u root $JENKINS_CONTAINER_NAME chmod 600 /var/jenkins_home/.ssh/$KEY_NAME
docker exec -u root $JENKINS_CONTAINER_NAME chmod 644 /var/jenkins_home/.ssh/$KEY_NAME.pub
docker exec -u root $JENKINS_CONTAINER_NAME chown jenkins:jenkins /var/jenkins_home/.ssh/$KEY_NAME
docker exec -u root $JENKINS_CONTAINER_NAME chown jenkins:jenkins /var/jenkins_home/.ssh/$KEY_NAME.pub

# Output the public key for reference
echo "Public key generated and copied to Jenkins container:"
cat $KEY_NAME.pub

echo "SSH key pair has been copied to the Jenkins container successfully."
