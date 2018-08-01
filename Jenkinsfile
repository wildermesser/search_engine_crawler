pipeline {
    agent { docker { image 'docker:stable-dind' } }
    environment { 
        REGISTRYCRED = credentials('registrypusher') 
    }
    stages {

        stage('build') {
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/$JOB_BASE_NAME:latest .'
                sh 'docker login -u $REGISTRYCRED_USR -p $REGISTRYCRED_PSW'
                sh 'docker push $REGISTRYCRED_USR/$JOB_BASE_NAME:latest'
            }
        }
        stage('test') {
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/$JOB_BASE_NAME:test -f Dockerfile-test .'
                sh 'docker run --rm $REGISTRYCRED_USR/$JOB_BASE_NAME:test'
            }
        }
    }
}
