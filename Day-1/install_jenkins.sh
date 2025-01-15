#!/bin/bash
sudo yum update –y

## Add Jenkins repo
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

## Import a key file from Jenkins-CI to enable installation
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum upgrade

## Install Java
sudo dnf install java-17-amazon-corretto -y

## Install Jenkins
sudo yum install jenkins -y

## Enable Jenkins
sudo systemctl enable jenkins

## Start Jenkins
sudo systemctl start jenkins

## Check a status
sudo systemctl status jenkins

##Allow port 8080 in sgs
