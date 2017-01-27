#!/bin/bash
wget -c http://www.vpnbook.com/free-openvpn-account/VPNBook.com-OpenVPN-Euro2.zip
unzip VPNBook.com-OpenVPN-Euro2.zip
lynx --dump http://www.vpnbook.com/ | grep Password > Password.txt
cat Password.txt | sed -e 's/\<Password\>//g' > 1outpass.lst
awk '{gsub(":", "");print}' 1outpass.lst > 2outpass.lst
awk '{gsub("+", "");print}' 2outpass.lst > 3outpass.lst
awk 'NR!~/^(2)$/' 3outpass.lst > 4outpass.lst
awk '{gsub(" ", "");print}' 4outpass.lst > vpnbookPassword.txt
cat vpnbookPassword.txt > userpass.txt
echo -e "vpnbook\n$(cat userpass.txt)" > login.conf
cat login.conf
#echo -e --auth-user-pass login.conf\n$(cat vpnbook-euro2-tcp443.ovpn)" > vpnbook-euro2-tcp443.ovpn
xterm -e sudo openvpn --config vpnbook-euro2-tcp443.ovpn --auth-user-pass login.conf auth-nocache --connect-retry-max 3 --single-session --tls-exit --nobind

