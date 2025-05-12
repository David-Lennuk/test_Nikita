pipeline {
    agent any

    stages {
        stage('Create an image') {
            steps { 
		sh 'docker build . -t hello-app'
            }
        }
    }
}
