#!/usr/bin/env groovy

pipeline { 
agent any  
stages {
         stage("First Stage : Create instances of test servers"){ 
       steps{
         sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/Stage1_Config_Hardware/tasks/main.yml'
         }
     }
	stage("Second Stage : Copy the code to the manager server"){ 
       steps{
         sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/Stage2_Copy_Code_to_Test_Server/tasks/main.yml'
         }
     }
	stage("Third Stage : Installation of the dependencies"){ 
       steps{
         sh 'ssh -oStrictHostKeyChecking=no ubuntu@10.11.53.41 \'sudo apt update && sudo apt install -y python\''
	 sh 'ssh -oStrictHostKeyChecking=no ubuntu@10.11.53.30 \'sudo apt update && sudo apt install -y python\''
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/Stage3_Install_Dependencies/tasks/main.yml'
         }
     }
     	stage("Fourth Stage : Launching the application"){ 
       steps{
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/Stage4_Launching_App/tasks/main.yml'
         }
     }
     	stage("Fifth Stage : Launching tests"){ 
       steps{
	 sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i ansible/hosts ansible/Stage5_Launching_Tests/tasks/main.yml'
         }
     }

 }
}
