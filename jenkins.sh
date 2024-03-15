#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y




pipeline {
  agent any
  tools {
    maven "MAVEN3"
    jdk "OracleJDK11"
  }
  stages {
    stage('Fetch Code') {
      steps {
        git branch: 'main', url: 'https://github.com/hkhcoder/vprofile-project.git'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn install -DskipTests'
      }
      post {
        success {
          echo 'Archiving artifacts now.'
          archiveArtifacts artifacts: '**/*.war'
        }
      }
    }
    stage('Unit tests') {
      steps {
        sh 'mvn test'
      }
    }
  }
}



pipeline {
  agent any
  tools {
    maven "MAVEN3"
    jdk "OracleJDK11"
  }
  stages {
    stage('Fetch Code') {
      steps {
        git branch: 'main', url: 'https://github.com/hkhcoder/vprofile-project.git'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn install -DskipTests'
      }
      post {
        success {
          echo 'Archiving artifacts now.'
          archiveArtifacts artifacts: '**/*.war'
        }
      }
    }
    stage('Unit tests') {
      steps {
        sh 'mvn test'
      }
    }
    stage('Checkstyle') {
      steps {
        sh 'mvn checkstyle:checkstyle'
      }
    }
    stage('Sonar Analysis') {
      environment {
        scannerHome = tool 'sonar4.7'
      }
      steps {
        withSonarQubeEnv('sonar') {
          sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
          -Dsonar.projectName=vprofile \
          -Dsonar.projectVersion=1.0 \
          -Dsonar.sources=src/ \
          -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
          -Dsonar.junit.reportsPath=target/surefire-reports/ \
          -Dsonar.jacoco.reportsPath=target/jacoco.exec \
          -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
        }
      }
    }
    stage("Quality Gate") {
      steps {
        timeout(time: 1, unit: 'HOURS') {
          waitForQualityGate abortPipeline: true
        }
      }
    }
    stage("UploadArtifact") {
      steps {
            nexusArtifactUploader(
        nexusVersion: 'nexus3',
        protocol: 'http',
        nexusUrl: '172.31.60.169',
        groupId: 'QI',
        version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
        repository: 'vprofile-repo',
        credentialsId: 'nexuslogin',
        artifacts: [
            [artifactId: 'vproapp',
             classifier: '',
             file: 'target/vprofile-v2.war',
             type: 'war']
        ]
     )
      }
    }
  }

}


pipeline {
    agent any
    tools {
	    maven "MAVEN3"
	    jdk "OracleJDK11"
	}

    environment {
        registryCredential = 'ecr:us-east-1:awscreds'
        appRegistry = "831544737975.dkr.ecr.us-east-1.amazonaws.com/vprofileappimg"
        vprofileRegistry = "https://831544737975.dkr.ecr.us-east-1.amazonaws.com"
    }
  stages {
    stage('Fetch code'){
      steps {
        git branch: 'docker', url: 'https://github.com/devopshydclub/vprofile-project.git'
      }
    }


    stage('Test'){
      steps {
        sh 'mvn test'
      }
    }

    stage ('CODE ANALYSIS WITH CHECKSTYLE'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }

        stage('build && SonarQube analysis') {
            environment {
             scannerHome = tool 'sonar4.7'
          }
            steps {
                withSonarQubeEnv('sonar') {
                 sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile-repo \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }

    stage('Build App Image') {
       steps {

         script {
                dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", "./Docker-files/app/multistage/")
             }

     }

    }

    stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( vprofileRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
     }

  }
}


pipeline {
    agent any
    environment {
        registryCredential = 'ecr:us-east-2:awscreds'
        appRegistry = "951401132355.dkr.ecr.us-east-2.amazonaws.com/vprofileappimg"
        vprofileRegistry = "https://951401132355.dkr.ecr.us-east-2.amazonaws.com"
        cluster = "vprofile"
        service = "vprofileappsvc"
    }
  stages {
    stage('Fetch code'){
      steps {
        git branch: 'docker', url: 'https://github.com/devopshydclub/vprofile-project.git'
      }
    }


    stage('Test'){
      steps {
        sh 'mvn test'
      }
    }

    stage ('CODE ANALYSIS WITH CHECKSTYLE'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }

        stage('build && SonarQube analysis') {
            environment {
             scannerHome = tool 'sonar4.7'
          }
            steps {
                withSonarQubeEnv('sonar') {
                 sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile-repo \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }

    stage('Build App Image') {
       steps {

         script {
                dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", "./Docker-files/app/multistage/")
             }

     }

    }

    stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( vprofileRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
     }

     stage('Deploy to ecs') {
          steps {
        withAWS(credentials: 'awscreds', region: 'us-east-2') {
          sh 'aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment'
        }
      }
     }

  }
}




