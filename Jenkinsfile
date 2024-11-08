pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ocinz/nextjs-app"
        SERVER_IP = "your-server-ip"  // Ganti dengan IP server Anda
        SSH_USER = "your-ssh-user"    // Ganti dengan username SSH yang memiliki akses ke server
    }

    stages {
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Membangun image Docker di server Jenkins
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    // Menjalankan perintah SSH untuk menyalin kode dan membangun container di server
                    sh """
                    ssh ${SSH_USER}@${SERVER_IP} '
                        # Masuk ke direktori proyek di server
                        cd /path/to/your/project || exit 1
                        
                        # Pull kode terbaru dari GitHub
                        git pull origin main || exit 1

                        # Menghentikan dan menghapus container lama jika ada
                        docker stop nextjs-app || true
                        docker rm nextjs-app || true

                        # Membangun image Docker secara lokal
                        docker build -t ${DOCKER_IMAGE} . || exit 1

                        # Menjalankan container dengan nama "nextjs-app"
                        docker run -d --name nextjs-app -p 80:3000 ${DOCKER_IMAGE} || exit 1
                    '
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment berhasil!'
        }
        failure {
            echo 'Deployment gagal.'
        }
    }
}
