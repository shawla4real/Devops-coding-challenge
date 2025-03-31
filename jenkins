pipeline {
  agent any
  tools{
      terraform 'Terraform'
  }
  environment {
      AWS_REGION = 'us-east-1'
      ECR_FRONTEND = '662508601281.dkr.ecr.us-east-1.amazonaws.com/frontend'
      ECR_BACKEND = '662508601281.dkr.ecr.us-east-1.amazonaws.com/backend'
      SERVICE_NAME_B = 'backend-service'
      CLUSTER_NAME = 'Devops-cluster'
      SERVICE_NAME = 'frontend-service'
      
  }
  stages {
    stage('Checkout') {
      steps {
        git changelog: false, credentialsId: '1499690d-4203-4f89-9120-e4f644ef4210', url: 'https://github.com/shawla4real/LF-coding-challenge.git'
      }
    }
   
    stage('Build Backend') {
      steps {
        script {
          dir('my-backend') {
            sh 'pwd'
            sh 'ls -l'
            sh ' docker build -t ${ECR_BACKEND}:$BUILD_NUMBER  .'
          }
        }
      
      }
    }  

    stage('Build Frontend') {  // Renamed the second "Install Dependencies & Build" stage
      steps {
        script {
          dir('my-frontend') {

            sh  'docker build -t ${ECR_FRONTEND}:$BUILD_NUMBER .'
           
          }
        }
      }
    }
    stage('Login to ECR') {
      steps {
        withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
          aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
          aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
          aws configure set region ${AWS_REGION}
          aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_BACKEND}
          aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_FRONTEND}
          '''
        }
      }
    }

    stage('Push to ECR') {
      steps {

        sh 'docker push ${ECR_BACKEND}:$BUILD_NUMBER'
        sh 'docker push ${ECR_FRONTEND}:$BUILD_NUMBER'
      }
    }
    stage('terraform') {  
      steps {
        script {
          dir('./terraform') {

            sh 'terraform init'
            sh 'terraform plan -var "build_number=${BUILD_NUMBER}"'
            sh 'terraform apply -var "build_number=${BUILD_NUMBER}" --auto-approve'
           
          }
        }
      }
    }
    stage('deploy to ECS') {  
      steps {
        script {
            sh 'aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME_B} --force-new-deployment --region ${AWS_REGION}'
            sh 'aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --force-new-deployment --region ${AWS_REGION}'
          
           
          
        }
      }
    } 
 }
}