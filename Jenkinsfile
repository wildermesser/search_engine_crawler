pipeline {
    agent { docker { image 'docker:stable-dind' } }
    stages {
        stage('build') {
            environment { 
                REGISTRYCRED = credentials('registrypusher') 
            }
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/se_crawler .'
                sh 'docker login -u $REGISTRYCRED_USR -p $REGISTRYCRED_PSW'
                sh 'docker push $REGISTRYCRED_USR/se_crawler'
            }
        }
    }
}
