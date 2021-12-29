pipeline {
    
    agent any
    
    stages {
        
        stage("git login"){
            steps{
                git 'https://github.com/vikash-kumar01/Jenkins-Docker-Project.git'
            }
        }
         stage("Sending docker file to ansible server"){
            steps{
                sshagent(['ansible']) {
                 sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.32.215'
                 sh 'scp /var/lib/jenkins/workspace/docker_image/* ubuntu@172.31.32.215:/opt/ansible'
                }
            }
        }
         stage("docker build"){
             steps{
        sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:v1.$BUILD_ID'
        sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:latest'
             }
         }
         stage("push Image: DOCKERHUB"){
             steps{
                 withCredentials([string(credentialsId: 'docker_pwd', variable: 'docker_passwd')]) {
                 sh "docker login -u vikashashoke -p ${docker_passwd}"
                sh 'docker image push vikashashoke/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image push vikashashoke/$JOB_NAME:latest'
               //A number of images will get stored into our jenkins server so need to remove prev build images
                //local images,taged images & latest images all delete 
              sh 'docker image rm $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:latest'
              }
             }
         }
           stage("Docker Container Deployment"){
                steps {
        // def docker_run = 'docker run -p 9000:80 -d --name scripted-pipeline-demo vikashashoke/scripted-pipeline-demo:latest'
        //def docker_rmv_container = 'docker run -p 9000:80 -d --name scripted-pipeline-demo vikashashoke/scripted-pipeline-demo:latest'
        //def docker_rmi = 'docker rmi -f vikashashoke/scripted-pipeline-demo'
        // container deployment need to be done on remote host server DOCKER-Host so ssh-Agent plugin required in jenkins
       sshagent(['docker_passwd']) {
    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.32.215 docker rm -f scripted-pipeline-demo"
    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.32.215 docker rmi -f vikashashoke/scripted-pipeline-demo"
    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.32.215 docker run -p 9000:80 -d --name scripted-pipeline-demo vikashashoke/scripted-pipeline-demo:latest"
    //Once sucess try with Docker-Host_IP:Port
    //Once after Changing the Dockerfile it says port already allocated to prev container whom we didn't yet deleted
    // therefor ist delete the prev container so that port will be free then try creating a new 
    //But still it'll not update because latest image is already in server it's not going to dockerHub to pull latest commmit so need to remove images also
       }
                }
             }
    
          
        /* stage("Building Docker Image"){
            steps{
                script {
                     sshagent(['ansible']) {
                sh 'echo $PWD'
                sh 'ssh -t -t ubuntu@172.31.32.215 -o StrictHostKeyChecking=no "echo pwd && cd /opt/ansible && echo pwd"'
               //sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.32.215'
               //sh 'cd /opt/ansible'
               sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
               sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:v1.$BUILD_ID'
               sh 'docker image tag $JOB_NAME:v1.$BUILD_ID vikashashoke/$JOB_NAME:latest'
                }
            }
            }
        } */
    }
}
