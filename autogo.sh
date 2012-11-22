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
printf "This script is a tool to install Golang 1.0.3 \n"
printf "\n"
printf "Any problems please send mail to longniao@gmail.com \n"
printf "=======================================================================\n"

install="n"
echo ""
echo "do you want to install the Golang?"
echo "(Default no,if you want please input: y"
read -p "if not please press the enter button):" install

case "$install" in
y|Y|Yes|YES|yes|yES|yEs|YeS|yeS)
echo "You will install the Golang!"
install="y"
;;
n|N|No|NO|no|nO)
echo "You will NOT install Golang!"
install="n"
;;
*)
echo "INPUT error,Golang will NOT install!"
install="n"
esac

if [ $install = "y" ]; then
	echo "Press any key to start installation or Press Ctrl+C to cancel..."
	char=`get_char`
else
	echo "exit install golang......"
	echo "goodbye"
	exit
fi

clear

echo ""
printf "======================Check If Golang Is Installed=====================\n"
echo ""

goinfo=`go`
if [ "$goinfo" != '' ]; then

echo "you hava installed golang"
echo "do you want to overwrite?"
echo "(Default no,if you want please input: y"
read -p "if not please press the enter button):" overwrite

case "$overwrite" in
y|Y|Yes|YES|yes|yES|yEs|YeS|yeS)
echo "You will install golang!"
overwrite="y"
;;
n|N|No|NO|no|nO)
echo "You will NOT install golang!"
overwrite="n"
;;
*)
echo "INPUT error, You will NOT install golang!"
overwrite="n"
esac

echo ""
if [ $overwrite = "n" ]; then
	echo "exit install golang......"
	echo "Press any key to start installation or Press Ctrl+C to cancel..."
	echo ""
	char=`get_char`
	echo "goodbye"
	exit
else
	echo "Press any key to start installation or Press Ctrl+C to cancel..."
	echo ""
	char=`get_char`

	printf "=======================================================================\n"
	echo ""
	echo "start an new project ......"
	echo ""
fi

fi


echo ""
echo "start install golang......"
echo ""
sleep 1

printf "===================== Check And Download Files ========================\n"

if [ -s go1.0.3.src.tar.gz ]; then
  echo "go1.0.3.src.tar.gz [found]"
  else
  echo "Error: go1.0.3.src.tar.gz not found!!!download now......"
  wget -c http://go.googlecode.com/files/go1.0.3.src.tar.gz
  echo "download done"
fi

echo ""
sleep 1

printf "=========================== install Golang ============================\n"

echo "start uncompress ......"
echo ""

tar -C /usr/local -xzf go1.0.3.src.tar.gz

echo "uncompress done"
echo ""
sleep 1

echo "======================================================================="
echo ""
echo "2. config golang environment ......"
echo ""

echo "export GOROOT=/usr/local/go" >> /etc/profile
echo "export PATH=$PATH:$GOROOT/bin" >> /etc/profile
source /etc/profile

echo "config done"
echo ""
sleep 1

echo "======================================================================="
echo ""
echo "3. install golang......"
echo ""

cd /usr/local/go/src/
./make.bash

echo "golang installed"
echo ""
sleep 1

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

	yum install git git-gui

	echo ""
	echo "git installed ......"
	echo ""
fi

echo "all installed"
echo "Press any key to exit..."
read anykey
exit
