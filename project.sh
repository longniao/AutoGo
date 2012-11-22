#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install golang"
    exit 1
fi

clear

get_char()
{
  SAVEDSTTY=`stty -g`
  stty -echo
  stty raw
  dd if=/dev/tty bs=1 count=1 2> /dev/null
  stty -raw
  stty echo
  stty $SAVEDSTTY
}

cd ~

printf "=======================================================================\n"
printf "AutoGo V0.1 for CentOS/RadHat Linux VPS ,  Written by Longniao \n"
printf "=======================================================================\n"
printf "This script is a tool to install Golang Project \n"
printf "\n"
printf "Any problems please send mail to longniao@gmail.com \n"
printf "=======================================================================\n"

installproject="n"
echo "do you want to start an new project?"
echo "(Default no,if you want please input: y"
read -p "if not please press the enter button):" installproject

case "$installproject" in
y|Y|Yes|YES|yes|yES|yEs|YeS|yeS)
echo "You will start an new project!"
installproject="y"
;;
n|N|No|NO|no|nO)
echo "You will NOT start an new project!"
installproject="n"
;;
*)
echo "INPUT error, You will NOT start an new project!"
installproject="n"
esac

echo ""
if [ $installproject = "y" ]; then
	echo "Press any key to start installation or Press Ctrl+C to cancel..."
	echo ""
	char=`get_char`

	echo "======================================================================="
	echo ""
	echo "start an new project ......"
	echo ""

	gopath=""
	echo "Please input project path:"
	read -p "(Default GOPATH: ~):" gopath
	if [ "$gopath" = "" ]; then
		gopath="mygo"
	fi
	
	mygopath=~/$gopath
	if [ ! -d $mygopath ]; then
		mkdir $mygopath
	fi

	echo "export GOPATH=$mygopath" >> /etc/profile
	source /etc/profile

	sleep 1
fi


echo ""
echo "======================================================================="

installgit="n"
echo "do you want to install git?"
echo "(Default no,if you want please input: y"
read -p "if not please press the enter button):" installgit

case "$installgit" in
y|Y|Yes|YES|yes|yES|yEs|YeS|yeS)
echo "You will install git!"
installgit="y"
;;
n|N|No|NO|no|nO)
echo "You will NOT install git!"
installgit="n"
;;
*)
echo "INPUT error, You will NOT install git!"
installgit="n"
esac

echo ""
if [ $installgit = "y" ]; then
	echo "Press any key to start..."
	echo ""
	read anykey

	echo "======================================================================="
	echo ""
	echo "install git ......"
	echo ""

	yum install git

	echo ""
	echo "git installed ......"
	echo ""
fi

echo "all installed"
echo "Press any key to exit..."
read anykey
exit
