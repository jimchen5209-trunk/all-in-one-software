#!/usr/bin/env bash

# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
BLUE='\033[34m' # BLUE
CYAN='\033[36m' # CYAN
WHITE='\033[37m' # WHITE
BOLD='\033[1m' # BOLD
CLEAR='\033[0m'   # Clear color and formatting

# Startup
echo -e "${BLUE}${BOLD}=> ${WHITE}Install Basic Tool${CLEAR}"

# Activate sudo permission
echo -e "\n${BLUE}${BOLD}=> ${WHITE}Check for sudo permission${CLEAR}"
sudo -v

do-system-upgrade() {
    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Update software list${CLEAR}"
    sudo apt -y update

    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Upgrade system softwares${CLEAR}"
    sudo apt -y upgrade
}

install-basic-tools() {
    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Git${CLEAR}"
    sudo apt -y install git

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Curl & Wget${CLEAR}"
    sudo apt -y install curl wget
    
    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Vim${CLEAR}"
    sudo apt -y install vim

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Htop${CLEAR}"
    sudo apt -y install Htop

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Z-Shell${CLEAR}"
    sudo apt -y install zsh

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Neofetch${CLEAR}"
    sudo apt -y install neofetch
}

install-all() {
    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Update the system${CLEAR}"
    do-system-upgrade

    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install basic tools${CLEAR}"
    install-basic-tools

}

install-all