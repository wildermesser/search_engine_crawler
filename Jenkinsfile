pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            environment { 
                REGISTRYCRED = credentials('registrypusher') 
            }
            steps {
                docker build -t $REGISTRYCRED_USR/se_crawler .
                docker login -u $REGISTRYCRED_USR -p $REGISTRYCRED_PSW
                docker push $REGISTRYCRED_USR/se_crawler
            }
        }
    }
}
