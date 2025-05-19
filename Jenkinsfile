pipeline {
    agent any

    stages {
        stage('app'){
            steps{
                sh 'npm i'
                sh 'docker build -t express .'
                sh 'docker rin -d -p 3000:3000 express'
            }
        }
    }
}
