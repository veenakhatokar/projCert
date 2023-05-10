pipeline {
    agent any
    tools {
        jdk 'java1.8'
    }
    stages {
        stage('compile') {
	         steps {
                // step1 
                echo 'compiling..'
		           // git url: 'https://github.com/edureka-devops/projCert'
                              git url: 'https://github.com/veenakhatokar/projCert'
		           // sh script: '/opt/maven/bin/mvn compile'
			 //sh 'composer install'
           }
        }
        stage('codereview-pmd') {
	         steps {
                // step2
                echo 'codereview..'
		           // sh script: '/opt/maven/bin/mvn -P metrics pmd:pmd'
			// sh 'find app -name "*.php" -print0 | xargs -0 -n1 php -l'
           }
	         post {
               success {
		             recordIssues enabledForFailure: true, tool: pmdParser(pattern: '**/target/pmd.xml')
               }
           }		
        }
        stage('unit-test') {
	          steps {
                // step3
                echo 'unittest..'
	             //  sh script: '/opt/maven/bin/mvn test'
            }
	          post {
               success {
                   junit 'target/surefire-reports/*.xml'
               }
            }			
        }
        stage('package/build-war') {
	         steps {
                // step5
                echo 'package......'
		          //  sh script: '/opt/maven/bin/mvn package'	
           }		
        }
        stage('build & push docker image') {
	         steps {
              withDockerRegistry(credentialsId: 'DOCKER_HUB_LOGIN', url: 'https://index.docker.io/v1/') {
                    sh script: 'cd  $WORKSPACE'
                    sh script: 'docker build --file Dockerfile --tag docker.io/veenakhatokar/projCert:$BUILD_NUMBER .'
                    sh script: 'docker push docker.io/veenakhatokar/projCert:$BUILD_NUMBER'
              }	
           }		
        }
    stage('Deploy-App-QA') {
  	   steps {
              sh 'ansible-playbook --inventory /tmp/inv $WORKSPACE/deploy-kube.yml --extra-vars "env=qa build=$BUILD_NUMBER"'
	   }
	   //post { 
           //   always { 
           //     cleanWs() 
	   //   }
	   //}
	}
    }
}
