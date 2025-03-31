# Overview
This repository contains a React frontend, and an Express backend that the frontend connects to.

# Objective
Assignment 

Deploy a Jenkins server to AWS, and make it publicly accessible over the internet.
EC2: The Jenkins server, install jenkins, docker, and 
Security group: TO control traffic to Jenkins, ECS, and ALB. 
IAM Roles-	two roles need to be created, one for jenkins to interact with aws services and the other for ECS to pull images from ECR
ECR	: storage for frontend/backend Docker image

Jenkins- terraform folder has all  terraform code used to deploy the  jenkins insfrastructure
MY-backend
My- Frontend 
are the application that was used as the forked application kept throwing alot of errors .
terraform folder has code used to deploy the AWS ECS

frontend ip.address; http://98.81.69.191:3000
jenkins ; http://3.239.180.246:8080
github : https://github.com/shawla4real/LF-coding-challenge
​To complete the LF coding challenge, I utilized the following technologies:​

Frontend: Developed using React, 

Backend: Implemented with Node.js and Express, ​

Deployment: Both applications were containerized using Docker and deployed on AWS Elastic Container Service (ECS)​

I used Terraform to provision my infrastructures, Git as the SCM and Jenkins for CICD
