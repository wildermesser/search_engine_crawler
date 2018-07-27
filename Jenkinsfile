pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            steps {
                sh 'docker info'
            }
        }
    }
}