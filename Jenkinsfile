pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            environment { 
                REGISTRYCRED = credentials('registrypusher') 
            }
            steps {
                echo REGISTRYCRED_USR
                echo env.REGISTRYCRED_USR
                docker info
            }
        }
    }
}
