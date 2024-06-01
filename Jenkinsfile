pipeline{
    agent any
    stages{
        stage("hello"){
            steps{
                echo "Hello World"
            }
        }
        
        stage("git pull"){
          steps{
               checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Akp-108/Java_Spring_Boot_Microservice']])
          }
        }
        
        stage("Test"){
            steps{
                sh 'mvn test'
            }
        }
        
        stage("build stage"){
            steps{
                sh "mvn clean package"
            }
        }
        
        stage("Build-And-Push-To-Ecr"){
            steps{
                withAWS(credentials: 'AWS_CRED', region: 'us-east-1') {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 154100284802.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker build -t java_jenkins .'
                sh "docker tag java_jenkins:latest 154100284802.dkr.ecr.us-east-1.amazonaws.com/java_jenkins:${BUILD_ID}"
                sh 'docker push 154100284802.dkr.ecr.us-east-1.amazonaws.com/java_jenkins:${BUILD_ID}'
                }
            }
        }
        
        
        stage('Integrate Jenkins with EKS Cluster and Deploy App') {
            steps {
                withAWS(credentials: 'AWS_CRED', region: 'us-east-1') {
                  script {
                    
                    sh ('aws eks update-kubeconfig --name trendmicro-eks-cluster --region us-east-1')
                    sh  'sed -i "s/java_jenkins:latest/java_jenkins:${BUILD_ID}/g" deployment.yml'
                    sh "kubectl apply -f deployment.yml"
                }
                }
        }
    }
    }
}