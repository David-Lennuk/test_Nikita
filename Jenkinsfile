pipeline {
    agent any

    environment {
        IMAGE_NAME = 'lemmik-reisisihtkoht-app'
        CONTAINER_NAME = 'lemmik-reisisihtkoht-container'
        EXPECTED_RESPONSE_TEXT = 'Jaapan'
    }

    stages {
        stage('Koodi kloonimine') {
            steps {
                echo 'Kood on (eeldatavasti) kloonitud SCM seadistuse kaudu.'
            }
        }

        stage('Docker image ehitamine') {
            steps {
                script {
                    echo "Ehitame Docker image: ${IMAGE_NAME}"
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Docker konteineri käivitamine') {
            steps {
                script {
                    echo "Peatame ja eemaldame vana konteineri (kui eksisteerib): ${CONTAINER_NAME}"
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"

                    echo "Käivitame Docker konteineri: ${CONTAINER_NAME} pordil 3000"
                    sh "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                    sleep 5
                }
            }
        }

        stage('Endpointi /travel testimine') {
            steps {
                script {
                    echo "Testime /travel endpointi..."
                    def response = sh(script: "curl -sf http://localhost:3000/travel", returnStdout: true).trim()
                    if (response.contains(EXPECTED_RESPONSE_TEXT)) {
                        echo "Endpoint /travel töötab korrektselt ja tagastas: ${response}"
                    } else {
                        error "Endpoint /travel ei tagastanud oodatud teksti. Saadi: ${response}"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Koristame... peatame ja eemaldame konteineri ${CONTAINER_NAME}"
            sh "docker stop ${CONTAINER_NAME} || true"
            sh "docker rm ${CONTAINER_NAME} || true"
        }
    }
}
