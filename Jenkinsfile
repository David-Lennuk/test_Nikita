pipeline {
    agent any

    stages {
        stage('Create an image') {
            steps { 
		sh 'docker build . -t hello-app'
            }
        }
	stage("Create a container") {
	    steps { 
		sh 'docker run _p 4000:3000 -d hello-app'}
		}
	}
}
