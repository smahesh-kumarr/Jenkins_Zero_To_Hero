# Jenkins Master-Slave Architecture on AWS EC2

This repository contains documentation and configuration for setting up a Jenkins master-slave architecture on AWS EC2 with the following steps:

## Prerequisites
- AWS EC2 instances for Master and Agent nodes.
- Jenkins installed on the master node.
- Maven project on GitHub repository connected to Jenkins.
- Security groups configured with necessary ports: `8080`, `50000`, `22`, `80`.

## Setup Instructions

### 1. **Jenkins Master Setup**
- Launch an EC2 instance for the Jenkins master node.
- Install Jenkins on the master node.
- Install necessary Jenkins plugins.
- Configure Jenkins to connect to GitHub using webhooks for the Maven project.
- Set up agent ports (`50000`) in Jenkins master configuration.

### 2. **Security Group Configuration**
- Ensure the following ports are open for both the master and agent nodes:
  - `8080`: Jenkins web UI
  - `50000`: Jenkins agent communication
  - `22`: SSH for file transfers and communication
  - `80`: HTTP access if needed

### 3. **Agent Node Setup**
- Launch an EC2 instance for each agent node.
- Install the necessary software and dependencies on the agent instance.
- Download `agent.jar` from the Jenkins master using:
  ```bash
  curl -sO http://<MASTER_IP>:8080/jnlpJars/agent.jar
Transfer agent.jar to the agent instance using FTP (Filezilla):
Destination folder: /home/ubuntu/jenkins
Change file permissions with chmod +x agent.jar.

### 4. Connecting the Agent to the Master
- Run the following command on the agent node to connect it to the Jenkins master:
```bash
root@ip-172-31-19-238:/home/ubuntu/jenkins# java -jar agent.jar -url http://98.82.139.4:8080/ -secret 3fb3dd6bb75552b1d75a2c3bbb71d9aeb9224af724d04fa5b45fcf8c076617b0 -name "server-2" -webSocket -workDir "/home/ubuntu/jenkins"
Jan 21, 2025 8:49:35 AM org.jenkinsci.remoting.engine.WorkDirManager initializeWorkDir
```

### 5. Freestyle Project Configuration
- In Jenkins, create a freestyle project.
- In the "Restrict where this project can be run" section, select either server-1 or server-2 as the agent node to run the project.
- Ensure the project builds successfully on the selected agent node.
- This setup demonstrates how to configure a Jenkins master-slave architecture using AWS EC2 instances for a scalable and distributed build environment.

### Troubleshooting
- Ensure security groups and firewall settings allow communication between the master and agent nodes on the necessary ports.
- Check the Jenkins logs for any errors related to agent connections.
