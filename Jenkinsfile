pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            environment { 
                REGISTRYCRED = credentials('registrypusher') 
            }
            steps {
                docker build -t env.REGISTRYCRED_USR/se_crawler .
                docker login -u env.REGISTRYCRED_USR -p env.REGISTRYCRED_PSW
                docker push env.REGISTRYCRED_USR/se_crawler
            }
        }
    }
}
