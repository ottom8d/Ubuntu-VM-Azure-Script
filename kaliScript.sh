#!/bin/bash
apt update -y
apt upgrade -y
# msfconsole
apt-get install curl -y
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/>apt install ocl-icd-libopencl1 git build-essential -y
# hashcat
mkdir /installs && mkdir /installs/apps && cd /installs/apps
git clone https://github.com/hashcat/hashcat
cd hashcat
git submodule update –init
make
cd ../
git clone https://github.com/hashcat/hashcat-utils
cd hashcat-utils/src
make
cp *.bin ../bin
cd /home/HashCrackUser1
echo "export PATH=$PATH:/home/HashCrackUser1/hashcat" >> ~/.bashrc
source ~/.bashrc
# john
apt-get install john -y
