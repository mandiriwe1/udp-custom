#!/bin/bash

# ==========================================
#            YHDS UDP MENU
#         Creator : YHDS Developer
# ==========================================

# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Root Check
[[ $EUID -ne 0 ]] && {
    echo -e "${RED}Please run as root!${NC}"
    exit 1
}

# Install Dependency
for pkg in curl lolcat screenfetch; do
    command -v $pkg >/dev/null 2>&1 || \
    apt install -y $pkg >/dev/null 2>&1
done

# Get Public IP
get_ip() {
    curl -s --max-time 5 ipv4.icanhazip.com
}

# Get ISP
get_isp() {
    local isp
    isp=$(curl -s --max-time 5 ipinfo.io/org | cut -d " " -f2-)
    echo "${isp:-Unknown ISP}"
}

# UDP Status
get_udp_status() {
    if systemctl is-active --quiet udp-custom; then
        echo -e "${GREEN}● ONLINE${NC}"
    else
        echo -e "${RED}● OFFLINE${NC}"
    fi
}

# Header
banner() {
    echo
    echo -e "          ██╗   ██╗██╗  ██╗██████╗ ███████╗    ██╗   ██╗██████╗ ██████╗ " | lolcat
    echo -e "          ╚██╗ ██╔╝██║  ██║██╔══██╗██╔════╝    ██║   ██║██╔══██╗██╔══██╗" | lolcat
    echo -e "           ╚████╔╝ ███████║██║  ██║███████╗    ██║   ██║██║  ██║██████╔╝" | lolcat
    echo -e "            ╚██╔╝  ██╔══██║██║  ██║╚════██║    ██║   ██║██║  ██║██╔═══╝ " | lolcat
    echo -e "             ██║   ██║  ██║██████╔╝███████║    ╚██████╔╝██████╔╝██║     " | lolcat
    echo -e "             ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝     ╚═════╝ ╚═════╝ ╚═╝     " | lolcat
    echo
}

# Menu
while true; do
clear

IP=$(get_ip)
ISP=$(get_isp)
UDP_STATUS=$(get_udp_status)

banner

echo -e "${YELLOW}══════════════════════════════════════════════${NC}"
echo -e "${CYAN}              ⚡ YHDS UDP MENU ⚡${NC}"
echo -e "${YELLOW}══════════════════════════════════════════════${NC}"

echo -e "${WHITE} VPS IP     : ${GREEN}${IP}${NC}"
echo -e "${WHITE} ISP        : ${YELLOW}${ISP}${NC}"
echo -e "${WHITE} UDP STATUS : ${UDP_STATUS}"
echo

echo -e "${YELLOW}      ╔══════════════════════════════════════╗${NC}"
echo -e "${CYAN}      ║  1) Add New User                    ║${NC}"
echo -e "${CYAN}      ║  2) View All Users                  ║${NC}"
echo -e "${CYAN}      ║  3) Edit Existing User              ║${NC}"
echo -e "${CYAN}      ║  4) Delete User                     ║${NC}"
echo -e "${CYAN}      ║  5) Server Information              ║${NC}"
echo -e "${CYAN}      ║  6) Torrent Blocker                 ║${NC}"
echo -e "${CYAN}      ║  7) Remove Script                   ║${NC}"
echo -e "${CYAN}      ║  8) About                           ║${NC}"
echo -e "${CYAN}      ║  9) Restart UDP                     ║${NC}"
echo -e "${CYAN}      ║  0) Exit                            ║${NC}"
echo -e "${YELLOW}      ╚══════════════════════════════════════╝${NC}"

echo
echo -e "${BLUE}       ╔═══════════════════════════════════╗${NC}"
echo -e "       ║      PROJECT YHDS DEVELOPER      ║" | lolcat
echo -e "${WHITE}       ║      © 2019-2030 All Rights      ║${NC}"
echo -e "${BLUE}       ╚════════════•⊱✦⊰•═════════════════╝${NC}"
echo

read -rp " • Select Operation : " n

case $n in
    1)
        bash /etc/yhds/system/Adduser.sh
    ;;

    2)
        bash /etc/yhds/system/Userlist.sh
    ;;

    3)
        bash /etc/yhds/system/ChangeUser.sh
    ;;

    4)
        bash /etc/yhds/system/DelUser.sh
    ;;

    5)
        clear
        screenfetch -p
        echo
        read -n 1 -s -r -p "Press any key to continue..."
    ;;

    6)
        bash /etc/yhds/system/torrent.sh
    ;;

    7)
        bash /etc/yhds/system/RemoveScript.sh
    ;;

    8)
        clear
        echo -e "${GREEN}Project By YHDS Dev Team${NC}"
        echo -e "${YELLOW}Version : 1.0${NC}"
        echo
        read -n 1 -s -r -p "Press any key to continue..."
    ;;

    9)
        echo -e "${CYAN}Restarting UDP Custom...${NC}"
        systemctl restart udp-custom

        if systemctl is-active --quiet udp-custom; then
            echo -e "${GREEN}✓ UDP Custom Restarted Successfully${NC}"
        else
            echo -e "${RED}✗ Failed Restart UDP Custom${NC}"
        fi
        sleep 2
    ;;

    0)
        clear
        exit
    ;;

    *)
        echo -e "${RED}Invalid Option!${NC}"
        sleep 1
    ;;
esac

done