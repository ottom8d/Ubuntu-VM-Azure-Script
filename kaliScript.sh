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
