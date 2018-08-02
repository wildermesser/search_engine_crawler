pipeline {
    agent { docker { image 'docker:stable-dind' } }
    environment { 
        REGISTRYCRED = credentials('registrypusher') 
        REPO_NAME = sh "echo $JOB_NAME| awk -F/ '{print \$1}'"
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
    }
}
