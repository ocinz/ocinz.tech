pipeline{
    agent any
    tools {nodejs "NodeJS 20"}
    stages{
        stage("Build"){
            steps{
                nodejs("NodeJS 20") {
                    sh 'npm install'
                    sh 'npm build'
                }
            }
        }
        stage("Start"){
            steps{
                nodejs("NodeJS 20") {
                    sh 'npm start'
                }
                echo "App started successfully"
            }
        }
    }
}