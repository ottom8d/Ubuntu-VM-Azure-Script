#!/bin/bash

apt-get update
# {create the nonroot user account in a way which can be scripted (pretty sure useradd instead of adduser, but then we need to set their default shell and passwd manually)}
password="This is a basic student password"
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -m -p "$pass" "$username"
# installing guacmole
apt-get install guacamole-tomcat
# change current directory
cd /var/lib/tomcat8/webapps/
wget http://apache.org/dyn/closer.cgi?action=download&filename=guacamole/1.1.0/binary/guacamole-1.1.0.war
touch /etc/tomcat8/Catalina/localhost/guacamole.xml
echo "<Context path="/guacamole" docbase="/var/lib/tomcat8/webapps/guacamole.war"" > /etc/tomcat8/Catalina/localhost/guacamole.xml
echo " <Resources allowLinking='true' />" >> /etc/tomcat8/Catalina/localhost/guacamole.xml
echo "</Context>" >> /etc/tomcat8/localhost/guacamole.xml
apt-get install xvnc4server
touch /etc/vncserver/vncservers.conf
echo "VNCSERVERS="1:student"" > /etc/vncserver/vncservers.conf
echo "VNCSERVERARGS[1]="-geometry 1600x900"" >> /etc/vncserver/vncservers.conf
mypasswd="here is the vnc password for this student account"
mkdir /home/student/.vnc
echo $mypasswd | vncpasswd -f > /home/$myuser/.vnc/passwd
chown -R student:student /home/$myuser/.vnc
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
