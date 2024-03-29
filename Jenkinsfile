pipeline {
   agent any
  
   environment {
       DOCKER_HUB_REPO = "mirceatereujanu/flask-app"
       CONTAINER_NAME = "flask-app"
       DOCKERHUB_CREDENTIALS=credentials('dockerhub-credentials')
 
   }
  
   stages {
       /* No need for a checkout stage - done by default when using the "Pipeline script from SCM" option. */
      
 
       stage('Build') {
           steps {
               echo 'Building..'
               sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
           }
       }
       stage('Test') {
           steps {
               echo 'Testing..'
               sh 'docker run --name $CONTAINER_NAME $DOCKER_HUB_REPO /bin/bash -c "pytest test.py && flake8"'
           }
       }
       stage('Push') {
           steps {
               echo 'Pushing image..'
               sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
               sh 'docker push $DOCKER_HUB_REPO:latest'
           }
       }
       stage('Deploy') {
           steps {
               echo 'Deploying....'
                sh 'kubectl version'
               sh 'kubectl apply -f deployment.yaml'
               sh 'kubectl apply -f service.yaml'
           }
       }
       stage('Cleanup') {
           steps {
                sh 'docker stop $CONTAINER_NAME || true'
                sh 'docker rm $CONTAINER_NAME || true'
           }
       }
   }
}