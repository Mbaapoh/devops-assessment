
# devops-assessment

A simple test application to call the GitHub API with the user defined in `pom.xml`.

## Requirements

- JAVA JDK 11+
- MAVEN 3.6+

## How to Build, Test, and Run

### Build

```bash
mvn compile
```

### Test

```bash
mvn test
```

### Execute

```bash
mvn exec:java
```

# Setting Up the Environment to Run the Project

1. **Clone the Repository**
   - Clone the repository from GitHub.

2. **Configure the Initial Setup**
   - Navigate to the `config` directory.
   - Grant execute permissions to the `initial-setup.sh` script:
     ```bash
     chmod +x initial-setup.sh
     ```
   - Run the `initial-setup.sh` script:
     ```bash
     ./initial-setup.sh
     ```
   - This script will create the home directory for your Jenkins container, copy all the Ansible configurations to the appropriate directory, and build and run the containers using Docker Compose:
     ```bash
     docker-compose up --build
     ```

3. **Access the Jenkins Container**
   - Once the container is up and running, open a web browser and access Jenkins using:
     - `localhost:port` or `server IP:port`
   - The `port` is specified in your `docker-compose.yml` file. By default, the port is set to `9090`, but you can change it as needed.
   - For example, if the port is `9090`, you would access Jenkins at:
     ```
     http://localhost:9090
     ```

4. **Generate and Copy the Necessary SSH Keys**
   - This step sets up the SSH keys needed for communication between Ansible, Jenkins, and the host. It can be done by running the `config.sh` script in the `config` directory.
     - Navigate to the `config` directory.
     - Grant execute permissions to the `config.sh` script:
       ```bash
       chmod +x config.sh
       ```
     - Run the `config.sh` script:
       ```bash
       ./config.sh
       ```

5. **Configure Jenkins**
   - After accessing the Jenkins GUI, follow the instructions provided in the Jenkins documentation to set up your server accordingly.

6. **Configure Ansible**
   - In the `ansible` directory, edit the `ansible/inventory/hosts.ini` file to reflect your local setup. Below is an example of the file's content to be updated:
     ```ini
     [jenkins_container]
     localhost ansible_connection=local

     [host_machine]
     10.0.2.15 ansible_connection=ssh ansible_user=mbaapoh
     ```
