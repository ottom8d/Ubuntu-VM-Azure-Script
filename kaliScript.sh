export DEBIAN_FRONTEND=noninteractive apt install
apt update -y
mkdir -p /labs/gatherHashes
mkdir -p /labs/crackHashes/otherHashes
mkdir -p /labs/hashID
mkdir -p /labs/john-jumbo
apt-get -y --force-confold install git build-essential libssl-dev zlib1g-dev
cd /labs/john-jumbo
git clone https://github.com/magnumripper/JohnTheRipper -b bleeding-jumbo john
cd /labs/john-jumbo/john/src
./configure && make -s clean && make -sj4
cd /labs/gatherHashes/
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/winMetListener.sh
chmod +x winMetListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/winNCListener.sh
chmod +x winNCListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/linuxMetListener.sh
chmod +x linuxMetListener.sh

export DEBIAN_FRONTEND=noninteractive sudo apt install
apt update -y
mkdir -p /labs/gatherHashes
mkdir -p /labs/crackHashes/otherHashes
mkdir -p /labs/hashID
mkdir -p /labs/john-jumbo
sudo apt-get -y --force-confold install git build-essential libssl-dev zlib1g-dev
cd /labs/john-jumbo
git clone https://github.com/magnumripper/JohnTheRipper -b bleeding-jumbo john
cd /labs/john-jumbo/john/src
./configure && make -s clean && make -sj4
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/hashes -O /labs/hashID/hashes
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/winMetListener.sh -O /labs/gatherHashes/winMetListener.sh
chmod +x winMetListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/winNCListener.sh -O /labs/gatherHashes/winNCListener.sh
chmod +x winNCListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/linuxMetListener.sh -O /labs/gatherHashes/linuxMetListener.sh
chmod +x linuxMetListener.sh
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/handler.rc -O /root/handler.rc
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/launcher.sh -O /root/launcher.sh
