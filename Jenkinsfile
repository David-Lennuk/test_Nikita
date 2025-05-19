pipeline {
    agent any // Või spetsiifiline agent, kui vajalik

    environment {
        IMAGE_NAME = 'lemmik-reisisihtkoht-app'
        CONTAINER_NAME = 'lemmik-reisisihtkoht-container'
        // Muuda "Jaapan" oma tegelikuks lemmikuks sihtkohaks, mida app.js tagastab!
        EXPECTED_RESPONSE_TEXT = 'Jaapan'
    }

    stages {
        stage('Koodi kloonimine') {
            steps {
                // See samm on tavaliselt Jenkinsi poolt automaatselt tehtud, kui seadistad SCM
                // Aga kui kasutad 'Pipeline script' otse, siis võid vajada:
                // git 'sinu_github_repo_url.git'
                echo 'Kood on (eeldatavasti) kloonitud SCM seadistuse kaudu.'
            }
        }

        stage('Docker image ehitamine') {
            steps {
                script {
                    echo "Ehitame Docker image: ${IMAGE_NAME}"
                    // Veendu, et Docker on Jenkinsi agendil kättesaadav
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Docker konteineri käivitamine') {
            steps {
                script {
                    echo "Peatame ja eemaldame vana konteineri (kui eksisteerib): ${CONTAINER_NAME}"
                    // Peata ja eemalda konteiner, kui see juba jookseb, et vältida konflikti
                    // '|| true' tagab, et käsk ei vea, kui konteinerit ei leita
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"

                    echo "Käivitame Docker konteineri: ${CONTAINER_NAME} pordil 3000"
                    sh "docker run -d -p 3000:3000 --name ${CONTAINER_NAME} ${IMAGE_NAME}"

                    // Anna konteinerile hetk käivitumiseks
                    sleep 5
                }
            }
        }

        stage('Endpointi /travel testimine') {
            steps {
                script {
                    echo "Testime /travel endpointi..."
                    // Kasuta curl'i, et teha päring ja kontrolli vastust
                    // -s teeb curl'i vaikseks (ei näita progressi)
                    // -f teeb curl'i ebaõnnestuma (exit code > 0) HTTP vigade korral (nt 404)
                    // grep otsib sinu sihtkoha nime vastusest. Kui ei leia, grep ebaõnnestub.
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
            // Koristamine: peata ja eemalda konteiner pärast pipeline'i lõppu
            echo "Koristame... peatame ja eemaldame konteineri ${CONTAINER_NAME}"
            sh "docker stop ${CONTAINER_NAME} || true"
            sh "docker rm ${CONTAINER_NAME} || true"
            // Võid ka pildi eemaldada, kui soovid ruumi säästa peale igat buildi
            // sh "docker rmi ${IMAGE_NAME} || true"
        }
    }
}
