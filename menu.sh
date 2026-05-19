#!/bin/bash

# ===== COLOR =====
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[97m"
ENDCOLOR="\e[0m"

# ===== ROOT CHECK =====
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Please run as root!${ENDCOLOR}"
    exit 1
fi

# ===== VPS INFO =====
get_ip() {
    wget -qO- https://ipecho.net/plain
}

get_isp() {
    curl -s ipinfo.io/org | cut -d " " -f2-
}

get_ram() {
    free -m | awk '/Mem:/ {print $3"MB / "$2"MB"}'
}

get_uptime() {
    uptime -p | sed 's/up //'
}

get_udp_custom_status() {
    if systemctl is-active --quiet udp-custom; then
        echo -e "${GREEN}RUNNING${ENDCOLOR}"
    else
        echo -e "${RED}OFFLINE${ENDCOLOR}"
    fi
}

get_zivpn_status() {
    if systemctl is-active --quiet zivpn; then
        echo -e "${GREEN}RUNNING${ENDCOLOR}"
    else
        echo -e "${RED}OFFLINE${ENDCOLOR}"
    fi
}

# ===== BANNER =====
banner() {
    echo
    echo -e "          ██╗   ██╗██╗  ██╗██████╗ ███████╗" | lolcat
    echo -e "          ╚██╗ ██╔╝██║  ██║██╔══██╗██╔════╝" | lolcat
    echo -e "           ╚████╔╝ ███████║██║  ██║███████╗" | lolcat
    echo -e "            ╚██╔╝  ██╔══██║██║  ██║╚════██║" | lolcat
    echo -e "             ██║   ██║  ██║██████╔╝███████║" | lolcat
    echo -e "             ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝" | lolcat
    echo
}

# ===== MENU =====
while true; do
clear

IP=$(get_ip)
ISP=$(get_isp)
RAM=$(get_ram)
UPTIME=$(get_uptime)
UDP_CUSTOM=$(get_udp_custom_status)
ZIVPN=$(get_zivpn_status)

banner

echo -e "${YELLOW}══════════════════════════════════════════════${ENDCOLOR}"
echo -e "${CYAN}              ⚡ YHDS UDP MENU ⚡${ENDCOLOR}"
echo -e "${YELLOW}══════════════════════════════════════════════${ENDCOLOR}"

echo -e "${WHITE} VPS IP         : ${GREEN}${IP}${ENDCOLOR}"
echo -e "${WHITE} ISP            : ${YELLOW}${ISP}${ENDCOLOR}"
echo -e "${WHITE} RAM STATUS     : ${CYAN}${RAM}${ENDCOLOR}"
echo -e "${WHITE} UPTIME         : ${GREEN}${UPTIME}${ENDCOLOR}"
echo -e "${WHITE} UDP CUSTOM     : ${UDP_CUSTOM}"
echo -e "${WHITE} UDP ZIVPN      : ${ZIVPN}"
echo

echo -e "${YELLOW}╔════════════════════════════════════════════╗${ENDCOLOR}"
echo -e "${CYAN}║ 1) Add New User                           ║${ENDCOLOR}"
echo -e "${CYAN}║ 2) View All Users                         ║${ENDCOLOR}"
echo -e "${CYAN}║ 3) Edit Existing User                     ║${ENDCOLOR}"
echo -e "${CYAN}║ 4) Delete User                            ║${ENDCOLOR}"
echo -e "${CYAN}║ 5) Server Information                     ║${ENDCOLOR}"
echo -e "${CYAN}║ 6) Torrent Blocker                        ║${ENDCOLOR}"
echo -e "${CYAN}║ 7) Remove Script                          ║${ENDCOLOR}"
echo -e "${CYAN}║ 8) About                                  ║${ENDCOLOR}"
echo -e "${CYAN}║ 9) Restart UDP Services                   ║${ENDCOLOR}"
echo -e "${CYAN}║ 0) Exit                                   ║${ENDCOLOR}"
echo -e "${YELLOW}╚════════════════════════════════════════════╝${ENDCOLOR}"

echo
echo -e "${BLUE}═══════════════════════════════${ENDCOLOR}"
echo -e "      PROJECT YHDS DEVELOPER" | lolcat
echo -e "${WHITE}      © 2019-2030 All Rights${ENDCOLOR}"
echo -e "${BLUE}═══════════════════════════════${ENDCOLOR}"
echo

echo -ne "${GREEN} • Select Operation : ${ENDCOLOR}"
read n

case $n in
1) /etc/yhds/system/Adduser.sh ;;
2) /etc/yhds/system/Userlist.sh ;;
3) /etc/yhds/system/ChangeUser.sh ;;
4) /etc/yhds/system/DelUser.sh ;;

5)
clear
screenfetch -p || neofetch || hostnamectl
read -p "Press Enter to return..."
;;

6) /etc/yhds/system/torrent.sh ;;
7) /etc/yhds/system/RemoveScript.sh ;;

8)
clear
echo "By Project YHDS Dev Team"
read -p "Press Enter to return..."
;;

9)
echo -e "${YELLOW}Restarting UDP Services...${ENDCOLOR}"
systemctl restart udp-custom
systemctl restart zivpn
sleep 3
;;

0)
clear
exit
;;

*)
echo -e "${RED}Invalid Option!${ENDCOLOR}"
sleep 2
;;
esac

done
