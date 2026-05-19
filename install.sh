#!/bin/bash
set -e

apt update -y
apt upgrade -y
apt install lolcat figlet neofetch screenfetch unzip wget -y

cd
rm -rf /root/udp
mkdir -p /root/udp

clear

echo -e "          ░█▀▀▀█ ░█▀▀▀█ ░█─── ─█▀▀█ ░█▀▀█   ░█─░█ ░█▀▀▄ ░█▀▀█ " | lolcat
echo -e "          ─▀▀▀▄▄ ─▀▀▀▄▄ ░█─── ░█▄▄█ ░█▀▀▄   ░█─░█ ░█─░█ ░█▄▄█ " | lolcat
echo -e "          ░█▄▄▄█ ░█▄▄▄█ ░█▄▄█ ░█─░█ ░█▄▄█   ─▀▄▄▀ ░█▄▄▀ ░█─── " | lolcat

sleep 3

echo "[+] Setting timezone Sri Lanka"
ln -fs /usr/share/zoneinfo/Asia/Colombo /etc/localtime

echo "[+] Download UDP-Custom"
wget -q --show-progress "https://github.com/mandiriwe1/udp-custom/raw/main/udp-custom-linux-amd64" -O /root/udp/udp-custom

chmod +x /root/udp/udp-custom

echo "[+] Download config"
wget -q --show-progress "https://raw.githubusercontent.com/mandiriwe1/udp-custom/main/config.json" -O /root/udp/config.json

chmod 644 /root/udp/config.json

EXCLUDE="$1"

echo "[+] Create systemd service"
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom Service (yhds mod)
After=network.target

[Service]
User=root
Type=simple
WorkingDirectory=/root/udp/
ExecStart=/root/udp/udp-custom server${EXCLUDE:+ -exclude "$EXCLUDE"}
Restart=always
RestartSec=2

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable udp-custom
systemctl restart udp-custom

clear
echo "[+] Installing UDP Manager"

mkdir -p /etc/yhds
cd /etc/yhds

wget -q "https://github.com/mandiriwe1/udp-custom/raw/main/system.zip" -O system.zip

unzip -o system.zip

cd system
mv menu /usr/local/bin/

chmod +x ChangeUser.sh Adduser.sh DelUser.sh Userlist.sh RemoveScript.sh torrent.sh /usr/local/bin/menu

rm -f ../system.zip

echo ""
echo "UDP Install By Yhds LK Dev Team"
echo "Support: GitHub/mandiriwe1"
echo ""

read -p "Reboot now? (y/n): " r
if [[ "$r" == "y" ]]; then
  reboot
fi
