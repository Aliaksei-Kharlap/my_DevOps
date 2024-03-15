#!/bin/bash
#echo "Hello, my scripts// exclamation (!)"
#uptime
#free -m
#df -h

# some comments

### hello ###



######################
### website set up ###
######################

#sudo apt install wget unzip httpd -y > /dev/null
#
#sudo systemctl start httpd
#sudo systemctl enable httpd
#
#mkdir -p /tmp/webfiles
#cd /tmp/webfiles
#
#wget https://www.tooplate.com/zip-templates/2098_health.zip
#unzip 2098_health.zip
#sudo cp -r 2098_health/* /var/www/html/
#
#systemctl restart httpd
#rm -rf /tmp/webfiles


######################
### website set up ###
######################

#sudo apt update
#sudo apt install apache2 wget unzip -y
#wget https://www.tooplate.com/zip-templates/2098_health.zip
#unzip 2098_health.zip
#sudo cp -r 2098_health/* /var/www/html/
#systemctl restart apache2













######################
### Variables ###
######################

#SKILL="DevOPs"
#echo $SKILL
#yum install $SKILL -y
 
#############################
### Command line arguments ###
#############################

#echo $0
#echo $1
#echo $2
#echo $3

# input /bin/bash /home/aliaksei-kharlap/PycharmProjects/My_DevOps/scripts.sh 3 1 2


#############################
### System variables ###
#############################

#$0 - the script name
#$1-9 - Command line arguments
#$# - how many arguments
#$? - the exit status of the most rexently run process
#$$ - the process ID of the current script
#$USER
#$HOSTNAME
#SRANDOM - random number
#$LINENO returns the current line number in Bash script


#############################
### Quotes  ''  "" ###
#############################

#SKILL="DevOPs"
#SKILL='DevOPs'
#
#echo "I have got $SKILL"
#echo 'I have got $SKILL'
#
#I have got DevOPs
#I have got $SKILL
#
#echo "i have got $SKILL and \$9 million"


#############################
### Command Substitution замена ###
#############################

#UP=`uptime`   #сохраняем вывод команды в переменную
#echo $UP
#
#USER_CUR=$(who)
#echo $USER_CUR
#
#FREE_RAM=`free -m | grep Память | awk '{print $4}'`
#echo $FREE_RAM



#############################
### Exporting variables   ###
#############################
#
#write script with variables
#create variables in the SHELL
#write command export VariablesNAME
#run script
#it will work but only in the one shell (parent and child)
#to solve this we can change .bashrc file in home directory for every user (define variables like
#SERS="something")
#to set variables for every users you can change /etc/profile like
#export SERE="something" in the end of the file


#############################
### USer input           ###
#############################

#read SKILL
#read -p 'Username: ' USR      you can write "Username: "
#read -sp 'Username: ' pass    you can write and user will not see what he write


#############################
### if statements         ###
#############################
#read SOME
#if [ $SOME -gt 100 ]     spaces are very important! (-eq равны)
#then
#  echo "We have entered in IF block"
#  sleep 3
#  echo
#  date
#elif [ $SOME -eq 100 ]
#then
#  echo "They are the same"
#else
#  echo "We are in else block"
#fi
#
#! expression       expression is False
#-n string      the length of string is greater than zero
#-z string      the length of string is zero
#string = string
#string != string
#integer -eq/-gt/-lt integer
#-d File       file exists and is a directory
#-e File       file exists
#-r File       file exists and the read permission is granted
#s File       file exists and it's size is greater than zero
#-w File       file exists and the write permission is granted
#-x File       file exists and the execute permission is granted


#############################
### LOOPS       ###
#############################

#for VAR1 in java .net php ruby
#do
#  echo $VAR1
#done
#
#
#USERS="aliaksei hkarlap asdsd"
#for VAR1 in $USERS
#do
#  echo $VAR1
#done
#
#
#counter=0
#while [ $counter -lt 5 ]
#do
#  echo "Hello"
#  counter=$(( $counter + 1 ))
#done
#
#while true
#do
#  echo "Hello"
#done


#############################
### REMOTE EXECUTION   ###
#############################

#ssh-keygen    generate keys
#ssh-copy-id username@hostname
#ssh username@hostname uptime     run a command on host
#
#to send a file to another machine write:
#scp testfile.txt username@hostname:/tmp/
