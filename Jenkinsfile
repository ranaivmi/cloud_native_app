#!/usr/bin/env groovy

pipeline { 
agent any  
stages {
         stage("First Stage : Create instances of test servers"){ 
       steps{
         sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts --vault-password-file=/var/lib/jenkins/vault/vault.key ansible/test/Stage1_Config_Hardware/tasks/main.yml'
         }
     }
     	stage("Second Stage : Copy the code to the test-manager server"){ 
       steps{
         sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/test/Stage2_Copy_Code_to_Test_Server/tasks/main.yml'
         }
     }

     	stage("Third Stage : Installation of the dependencies"){ 
       steps{
         sh 'ssh -oStrictHostKeyChecking=no ubuntu@10.11.53.41 \'test -e /usr/bin/python || (sudo apt update && sudo apt install -y python)\''
	 sh 'ssh -oStrictHostKeyChecking=no ubuntu@10.11.53.30 \'test -e /usr/bin/python || (sudo apt update && sudo apt install -y python)\''
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/test/Stage3_Install_Dependencies/tasks/main.yml'
         }
     }
     	stage("Fourth Stage : Launching the application on test environment"){ 
       steps{
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/test/Stage4_Launching_App/tasks/main.yml'
         }
     }
     	stage("Fifth Stage : Launching tests"){ 
       steps{
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/test/Stage5_Launching_Tests/tasks/main.yml'
         }
     }
        stage("Sixth Stage : Create instances of prod servers"){ 
       steps{
         sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts --vault-password-file=/var/lib/jenkins/vault/vault.key ansible/prod/Stage6_Config_Hardware/tasks/main.yml'
         }
     }
     	stage("Seventh Stage : Copy the code to the prod-manager server"){ 
       steps{
         sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/prod/Stage7_Copy_Code_to_Prod_Server/tasks/main.yml'
         }
     }

     	stage("Eighth Stage : Installation of the dependencies"){ 
       steps{
         sh 'ssh -oStrictHostKeyChecking=no ubuntu@10.11.54.93 \'test -e /usr/bin/python || (sudo apt update && sudo apt install -y python)\''
	 sh 'ssh -oStrictHostKeyChecking=no ubuntu@10.11.54.98 \'test -e /usr/bin/python || (sudo apt update && sudo apt install -y python)\''
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/prod/Stage8_Install_Dependencies/tasks/main.yml'
         }
     }
     	stage("Ninth Stage : Launching the application on production environment"){ 
       steps{
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/prod/Stage9_Launching_App/tasks/main.yml'
         }
     }

 }
}
