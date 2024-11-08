pipeline {
    agent any

    environment {
        NODE_VERSION = '20.x'  // Sesuaikan dengan versi Node.js yang digunakan oleh project
    }

    stages {
        stage('Prepare Environment') {
            steps {
                script {
                    // Menggunakan Node.js versi tertentu
                    tool name: "NodeJS ${env.NODE_VERSION}", type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                // Install dependencies dengan npm
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                // Menjalankan semua tes
                sh 'npm run test'
            }
        }

        stage('Build') {
            steps {
                // Build aplikasi untuk produksi
                sh 'npm run build'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'  // Lakukan deploy hanya pada branch 'main'
            }
            steps {
                // Copy file ke server remote menggunakan scp atau rsync
                // Contoh: menggunakan rsync untuk melakukan deploy
                sh '''
                rsync -avz --delete-after ./build/ user@your-server:/path/to/deployment/
                '''
                // Restart aplikasi di server (jika menggunakan PM2 atau service lain)
                sh 'ssh user@your-server "pm2 reload all"'  // Sesuaikan dengan cara restart aplikasi di server
            }
        }
    }

    post {
        always {
            echo 'Pipeline selesai.'
        }
        success {
            echo 'Pipeline berhasil.'
        }
        failure {
            echo 'Pipeline gagal.'
        }
    }
}
