pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            environment { 
                REGISTRYCRED = credentials('registrypusher') 
            }
            steps {
                echo env.REGISTRYCRED_USR
                echo $REGISTRYCRED_USR
                docker info
            }
        }
    }
}
