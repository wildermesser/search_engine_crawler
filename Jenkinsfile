pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            environment { 
                REGISTRYCRED = credentials('registrypusher') 
            }
            steps {
                docker build -t $REGISTRYCRED_USER/se_crawler .
                docker login -u $REGISTRYCRED_USER -p $REGISTRYCRED_PSW
                docker push $REGISTRYCRED_USER/se_crawler
            }
        }
    }
}
