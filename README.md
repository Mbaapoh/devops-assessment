# devops-assessment
Simple test application to call the github api with user defined in pom.xml

## Requirements ##
- JAVA JDK 11+
- MAVEN 3.6+

## How to build/test/run ##

### Build

mvn compile

### Test

mvn test

### Execute

###vvv

mvn exec:java


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
   - This script will create the home directory for your Jenkins container and copy all the Ansible configurations to the appropriate directory.
   - The script will also buid and run the containers using docker `compose up --build`

3. **Access the Jenkins Container**
   - Once the container is up and running, open a web browser and access Jenkins using:
     - `localhost:port` or `server IP:port`
   - The `port` is specified in your `docker-compose` file. By default, the port is set to `9090`, but you can change it as needed.
   - For example, if the port is `9090`, you would access Jenkins at:
     ```
     http://localhost:9090
     ```
4. Generating and copy the necessrary ssh keys needed for communictioan by ansibe, jenkins and host.  this can be done by runnig the bash script config.sh in config directory.
    - Navigate to the `config` directory.
    - Grant execute permissions to the `config.sh` script:
     ```bash
     chmod +x uconfigp.sh
     ```
    - Run the `config.sh` script:
     ```bash
     ./config.sh
     ```

5. **Configure Jenkins**
   - After accessing the Jenkins GUI, follow the instructions provided in the Jenkins documentation to set up your server accordingly.




