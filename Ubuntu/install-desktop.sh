#!/usr/bin/env bash

# Text Color Variables
GREEN='\033[32m'  # Green
YELLOW='\033[33m' # YELLOW
BLUE='\033[34m' # BLUE
CYAN='\033[36m' # CYAN
WHITE='\033[37m' # WHITE
BOLD='\033[1m' # BOLD
CLEAR='\033[0m'   # Clear color and formatting

# Install base first
sh -c "./install-base.sh --called-from-another"
# Startup
echo -e "${BLUE}${BOLD}=> ${WHITE}Install Desktop Tool${CLEAR}"

install-basic-tools() {
    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Microsoft Edge${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download deb file${CLEAR}"
    curl -SL https://go.microsoft.com/fwlink\?linkid\=2149051 --output edge.deb
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    sudo apt -y install ./edge.deb
}

install-dev-tools() {
    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Visual Studio Code${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download deb file${CLEAR}"
    curl -SL https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 --output code.deb
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    sudo apt -y install code.deb

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Insomnia${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download deb file${CLEAR}"
    curl -SL https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website --output insomnia.deb
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    sudo apt -y install insomnia.deb

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}MySQL Workbench${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Add repository${CLEAR}"
    sudo mkdir -p /etc/apt/keyrings
    sudo gpg --homedir /tmp --no-default-keyring --keyring /etc/apt/keyrings/mysql.gpg
    echo "deb [signed-by=/etc/apt/keyrings/mysql.gpg] http://repo.mysql.com/apt/ubuntu/ $(lsb_release -cs) mysql-8.0" | sudo tee -a /etc/apt/sources.list.d/mysql.list  > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mysql.gpg] http://repo.mysql.com/apt/ubuntu/ $(lsb_release -cs) mysql-tools" | sudo tee -a /etc/apt/sources.list.d/mysql.list  > /dev/null

    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Update apt source list${CLEAR}"
    sudo apt update

    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    sudo apt -y install mysql-workbench-community

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}MQTTX${CLEAR}"
    sudo snap install mqttx
}

install-all() {
    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install basic tools${CLEAR}"
    install-basic-tools
}

install-all
if [ "$1" != "--called-from-another" ]; then
    echo -e "\n${BLUE}${BOLD}=> ${WHITE}Install Complete! Restart your computer to continue!${CLEAR}"
else 
    echo -e "\n${BLUE}${BOLD}=> ${WHITE}Desktop Tool Install Complete!${CLEAR}\n"
fi