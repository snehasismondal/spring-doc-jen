pipeline{
    agent any
    tools{
        maven "maven"
    }

    environment {
                APP_NAME    = "spring-docker-cicd"
                RELEASE_NO  = "1.0.0"
                DOCKER_USER = "snemon"

        // In Groovy, you don't need "+" to join strings if you use double quotes
                IMAGE_NAME  = "${DOCKER_USER}/${APP_NAME}"

        // Use env.BUILD_NUMBER to be explicit, though BUILD_NUMBER usually works
                IMAGE_TAG   = "${RELEASE_NO}-${env.BUILD_NUMBER}"
            }


    stages{


        //SCM checkout
        stage("SCM checkout"){
            steps{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/snehasismondal/spring-jen-docker.git']])
            }
        }


        //build
        stage("Maven build"){
            steps{
                script{
                bat 'mvn clean install'
                }
            }

        }
        //build docker image
        stage("Build Image"){
            steps{
                script{
                    //bat 'docker build -t snemon/spring-cicd:1.0 .'
                    bat "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }

        }
        //push image to docker Hub
        stage("Deploy image to Hub"){
            steps{
                withCredentials([string(credentialsId: 'docker-creden', variable: 'docker-creden')]) {
                    bat "echo %docker-creden%| docker login -u snemon --password-stdin"
                    //bat 'docker push snemon/spring-cicd:1.0'
                    bat "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        //deploy WAR
        //send mail
    }
}