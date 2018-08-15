pipeline {
    agent { docker { image 'docker:stable-dind' } }
    environment { 
        REGISTRYCRED = credentials('registrypusher') 
        REPO_NAME = "crawler"
    }
    stages {
        stage('build') {
            steps {
                sh "docker build -t $REGISTRYCRED_USR/$REPO_NAME:$env.BRANCH_NAME ."
                sh "docker login -u $REGISTRYCRED_USR -p $REGISTRYCRED_PSW"
                sh "docker push $REGISTRYCRED_USR/$REPO_NAME:$env.BRANCH_NAME"
            }
        }
        stage('test') {
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/$REPO_NAME:test -f Dockerfile-test .'
                sh 'docker run --rm $REGISTRYCRED_USR/$REPO_NAME:test'
            }
        }
        stage('deploy_to_branch') {
            when { not { branch 'master' } }
            steps {
                withCredentials([file(credentialsId: 'gcloud', variable: 'GCLOUD_CREDS')]) {
                    sh "echo $GCLOUD_CREDS > account.json"
                }
                withCredentials([sshUserPrivateKey(credentialsId: '5284c251-c690-4f5f-9cd4-18da917f4369', keyFileVariable: 'SSH_PRODUCTION')]) {
                    sh "cat $SSH_PRODUCTION > infra/id_rsa"
                }
                sh 'wget -O terraform_0.11.7_linux_amd64.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip'
                sh 'unzip -o terraform_0.11.7_linux_amd64.zip'
                sh 'apk add git'
                sh "./terraform init -backend-config='prefix=terraform/state-$env.BRANCH_NAME' -backend-config='credentials=files/account.json'  infra/"
                sh "./terraform apply -auto-approve -var instance_name=$env.BRANCH_NAME -var-file=infra/terraform.tfvars infra/"
            }
        }     
        stage('remove_branch') {
            when { not { branch 'master' } }
            input {
                message "Remove branch instance?"
                ok "Yes"
            }
            steps {   
                sh 'cd infra'
                sh "./terraform init -backend-config='prefix=terraform/state-$env.BRANCH_NAME' -backend-config='credentials=files/account.json' infra/"
                sh "./terraform destroy -auto-approve -var instance_name=$env.BRANCH_NAME infra/"                 
            }
        }
        stage('deploy_to_prod') {
            when {branch 'master' }
            input {
                message "Deploy to production?"
                ok "Yes"
                submitter "admin"
            }
            steps {
                sh 'apk add openssh-client && mkdir ~/.ssh'
                withCredentials([sshUserPrivateKey(credentialsId: '5284c251-c690-4f5f-9cd4-18da917f4369', keyFileVariable: 'SSH_PRODUCTION')]) {
                    sh 'ssh-keyscan -t rsa production.ocrawler.tk > ~/.ssh/known_hosts'
                    sh "cat $SSH_PRODUCTION > ~/.ssh/id_rsa"
                    sh 'chmod 600 ~/.ssh/id_rsa'
                    sh 'ssh messer@production.ocrawler.tk sudo docker-compose down'
                    sh 'ssh messer@production.ocrawler.tk sudo docker-compose up -d'
                }
            }
        }
    }
}
