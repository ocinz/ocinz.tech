pipeline {
    agent any

    tools {
        nodejs "NodeJS 20"
    }

    environment {
        DEPLOY_DIR = "/var/www/ocinz.tech"  // Direktori tempat aplikasi Next.js dideploy
        NGINX_CONF = "/etc/nginx/sites-available/ocinz.tech"  // Path file konfigurasi Nginx
    }

    stages {
        stage("Build") {
            steps {
                nodejs("NodeJS 20") {
                    script {
                        // Install dependencies dan build aplikasi
                        sh 'npm install'
                        sh 'npm run build'
                    }
                }
            }
        }

        // stage("Start") {
        //     steps {
        //         nodejs("NodeJS 20") {
        //             script {
        //                 // Menjalankan Next.js di background dengan PM2 atau direktori lain
        //                 sh 'npm run start &'
        //                 echo "App started successfully"
        //             }
        //         }
        //     }
        // }

        stage("Deploy") {
            steps {
                script {
                    // Menyalin hasil build ke direktori deploy
                    sh """
                        sudo cp -r .next $DEPLOY_DIR/.next
                        sudo cp -r public $DEPLOY_DIR/public
                        sudo cp -r pages $DEPLOY_DIR/pages
                        sudo cp -r node_modules $DEPLOY_DIR/node_modules
                    """

                    // Konfigurasi Nginx
                    sh """
                        sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/ocinz.tech
                        sudo sed -i 's|root /var/www/html;|root $DEPLOY_DIR;|g' /etc/nginx/sites-available/ocinz.tech
                        sudo sed -i 's|server_name _;|server_name ocinz.tech;|g' /etc/nginx/sites-available/ocinz.tech
                        sudo systemctl restart nginx
                    """

                    echo "Application deployed successfully"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed"
        }

        success {
            echo "Deployment to $DEPLOY_DIR completed successfully"
        }

        failure {
            echo "Deployment failed"
        }
    }
}
