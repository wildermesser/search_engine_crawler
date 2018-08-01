pipeline {
    agent { docker { image 'docker:stable-dind' } }
    environment { 
        REGISTRYCRED = credentials('registrypusher') 
    }
    stages {

        stage('build') {
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/se_crawler .'
                sh 'docker login -u $REGISTRYCRED_USR -p $REGISTRYCRED_PSW'
                sh 'docker push $REGISTRYCRED_USR/se_crawler'
            }
        }
        stage('test') {
            steps {
                sh 'docker build -t $REGISTRYCRED_USR/se_crawler:test -f Dockerfile-test .'
                sh 'docker run -it --rm $REGISTRYCRED_USR/se_crawler:test'
            }
        }
    }
}
