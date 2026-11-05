pipeline {
    agent any
    tools {
        nodejs 'my-nodejs'
    }
    stages {
        stage('Increment version') {
            steps {
                script {
                    dir("app") {
                        echo "incrementing app version..."
                        sh "npm version minor --no-git-tag-version"
                        def version = sh(
                            script: 'node -p "require(\'./app/package.json\').version"',
                            returnStdout: true
                        ).trim()
                        env.IMAGE_NAME = "${version}-${env.BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Run tests') {
            steps {
                script {
                    dir("app") {
                        echo "Running tests..."
                        sh "npm install"
                        sh "npm run test"
                    }
                }
            }
        }

        stage('Build and Push docker image') {
            steps {
                script {
                    echo 'building the docker image...'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh "docker build -t cvacal96/demo-app:${IMAGE_NAME} ."
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh "docker push cvacal96/demo-app:${IMAGE_NAME}"
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }

        stage('commit version update') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'gitlab-credentials', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git config --global user.name "jenkins"'
                        sh 'git remote set-url origin https://$USER:$PASS@gitlab.com/twn-devops-bootcamp/latest/08-jenkins/jenkins-exercises.git'
                        sh 'git add .'
                        sh 'git commit -m "ci: version bump"'
                        sh 'git push origin HEAD:jenkins-jobs'
                    }
                }
            }
        }
    }
}