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


# Seting up the environment to run the project.
1.  After cloning the repo from github
2. Go to the config director and give exec permission to the initial-setup.sh bash file and run it. It will create the home dirctor fr you jenkins container and copy all the ansible configs to the appropriet directory.
3. When the container is spun up and running, go to the browwer and access it useig the localhost:port  or server IP:port where port is the port specified in your docker compose file, for the current setup the port is 9090 but you can change it to what you desire. So for my case to access the Jenkins server after seup i used localhot:9090
4.  After accessing the jenkins gui, you can follow the instructions as per jenkins documentations and set your server accordingly


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

3. **Access the Jenkins Container**
   - Once the container is up and running, open a web browser and access Jenkins using:
     - `localhost:port` or `server IP:port`
   - The `port` is specified in your `docker-compose` file. By default, the port is set to `9090`, but you can change it as needed.
   - For example, if the port is `9090`, you would access Jenkins at:
     ```
     http://localhost:9090
     ```

4. **Configure Jenkins**
   - After accessing the Jenkins GUI, follow the instructions provided in the Jenkins documentation to set up your server accordingly.




