pipeline{
    agent any
    tools {nodejs "NodeJS 20"}
    stages{
        stage("Build"){
            steps{
                nodejs("NodeJS 20") {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
        stage("Start"){
            steps{
                nodejs("NodeJS 20") {
                    sh 'npm run start'
                }
                echo "App started successfully"
            }
        }
    }
}