pipeline {
    agent { docker { image 'docker:stable-dind' } }
    environment { 
        REGISTRYCRED = credentials('registrypusher') 
        REPO_NAME = "crawler"
    }
    stages {
        stage('build') {
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/$REPO_NAME:latest .'
                sh 'docker login -u $REGISTRYCRED_USR -p $REGISTRYCRED_PSW'
                sh 'docker push $REGISTRYCRED_USR/$REPO_NAME:latest'
            }
        }
        stage('test') {
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/$REPO_NAME:test -f Dockerfile-test .'
                sh 'docker run --rm $REGISTRYCRED_USR/$REPO_NAME:test'
            }
        }
        stage('deploy_to_prod') {
            input {
                message "Deploy to production?"
                ok "Yes"
                submitter "admin"
            }
            steps {
                sh 'apk add openssh-client && mkdir ~/.ssh'
                withCredentials([sshUserPrivateKey(credentialsId: '5284c251-c690-4f5f-9cd4-18da917f4369', keyFileVariable: 'SSH_PRODUCTION')]) {
                    sh 'ssh-keyscan -t rsa production.ocrawler.tk > ~/.ssh/known_hosts'
                    sh 'ssh messer@production.ocrawler.tk sudo docker-compose down'
                    sh 'ssh messer@production.ocrawler.tk sudo docker-compose up -d'
                }
            }
        }
    }
}
