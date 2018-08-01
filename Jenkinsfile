pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            environment { 
                REGISTRYCRED = credentials('registrypusher') 
            }
            steps {
                sh 'echo REGISTRYCRED_USR'
                sh 'echo $REGISTRYCRED_USR'
                sh 'docker info'
            }
        }
    }
}
