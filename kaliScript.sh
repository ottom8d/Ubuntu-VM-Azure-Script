export DEBIAN_FRONTEND=noninteractive sudo apt install
sudo apt update -y
mkdir -p /labs/gatherHashes
mkdir -p /labs/crackHashes/otherHashes
mkdir -p /labs/hashID
mkdir -p /labs/john-jumbo
sudo apt-get -y install git build-essential libssl-dev zlib1g-dev
cd /labs/john-jumbo
git clone https://github.com/magnumripper/JohnTheRipper -b bleeding-jumbo john
cd /labs/john-jumbo/john/src
./configure && make -s clean && make -sj4
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/hashes -O /labs/hashID/hashes
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/winMetListener.sh -O /labs/gatherHashes/winMetListener.sh
chmod +x /labs/gatherHashes/winMetListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/winNCListener.sh -O /labs/gatherHashes/winNCListener.sh
chmod +x /labs/gatherHashes/winNCListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/linuxMetListener.sh -O /labs/gatherHashes/linuxMetListener.sh
chmod +x /labs/gatherHashes/linuxMetListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/handler.rc -O /root/handler.rc
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/launcher.sh -O /root/launcher.sh
printf "dh?w2qa3\ndh?w2qa3\n\n" | vncpasswd -f
echo '[Unit]' > /etc/systemd/system/tightvncserver.service
echo 'Description=TightVNC remote desktop server' >> /etc/systemd/system/tightvncserver.service
printf '\n' >> /etc/systemd/system/tightvncserver.service
echo '[Service]' >> /etc/systemd/system/tightvncserver.service
echo 'Type=dbus' >>  /etc/systemd/system/tightvncserver.service
echo 'ExecStart=/usr/bin/tightvncserver :1' >>  /etc/systemd/system/tightvncserver.service
echo 'User=HashCrackUser1' >> /etc/systemd/system/tightvncserver.service
echo 'Type=forking' >> /etc/systemd/system/tightvncserver.service
printf '\n' >> /etc/systemd/system/tightvncserver.service
echo '[Install]' >>  /etc/systemd/system/tightvncserver.service
echo 'WantedBy=multi-user.target' >>  /etc/systemd/system/tightvncserver.service
chown root:root /etc/systemd/system/tightvncserver.service
chmod 755 /etc/systemd/system/tightvncserver.service
systemctl start tightvncserver.service
