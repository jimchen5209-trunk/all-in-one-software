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
    cp edge.deb /tmp
    sudo apt -y install /tmp/edge.deb
}

install-dev-tools() {
    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Visual Studio Code${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download deb file${CLEAR}"
    curl -SL https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-deb-x64 --output code.deb
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    cp code.deb /tmp
    sudo apt -y install /tmp/code.deb

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Insomnia${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download deb file${CLEAR}"
    curl -SL https://updates.insomnia.rest/downloads/ubuntu/latest\?\&app=com.insomnia.app\&source=website --output insomnia.deb
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    cp insomnia.deb /tmp
    sudo apt -y install /tmp/insomnia.deb

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}MySQL Workbench${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Add repository${CLEAR}"
    sudo mkdir -p /etc/apt/keyrings
    sudo gpg --homedir /tmp --no-default-keyring --keyring /etc/apt/keyrings/mysql.gpg  --keyserver pgp.mit.edu --recv-keys 3A79BD29
    echo "deb [signed-by=/etc/apt/keyrings/mysql.gpg] http://repo.mysql.com/apt/ubuntu/ $(lsb_release -cs) mysql-8.0" | sudo tee -a /etc/apt/sources.list.d/mysql.list  > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mysql.gpg] http://repo.mysql.com/apt/ubuntu/ $(lsb_release -cs) mysql-tools" | sudo tee -a /etc/apt/sources.list.d/mysql.list  > /dev/null

    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Update apt source list${CLEAR}"
    sudo apt update

    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    sudo apt -y install mysql-workbench-community

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}MQTTX${CLEAR}"
    sudo snap install mqttx
}

install-personalize() {
    echo -e "\n${YELLOW}${BOLD}FONT ${BLUE}=> ${WHITE}Jetbrains Mono Nerd Font${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download font file${CLEAR}"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Extract font${CLEAR}"
    mkdir -p ~/.fonts
    unzip -q JetBrainsMono.zip -d ~/.fonts
    rm ~/.fonts/*Windows*
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Update font cache${CLEAR}"
    fc-cache -fv

    echo -e "\n${YELLOW}${BOLD}FONT ${BLUE}=> ${WHITE}Jetbrains Mono ${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download font file${CLEAR}"
    wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Extract font${CLEAR}"
    unzip -q JetBrainsMono-2.242.zip -d /tmp
    cp /tmp/fonts/variable/*.ttf ~/.fonts
    mv ~/.fonts/JetBrainsMono\[wght\].ttf ~/.fonts/JetBrainsMono.ttf
    mv ~/.fonts/JetBrainsMono-Italic\[wght\].ttf ~/.fonts/JetBrainsMono-Italic.ttf
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Update font cache${CLEAR}"
    fc-cache -fv
}

install-portainer() {
    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Create volume${CLEAR}"
    sudo docker volume create portainer_data

    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Startup${CLEAR}"
    sudo docker run -d -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
}

clean-up() {
    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Clean up deb files${CLEAR}"
    rm /tmp/*.deb
    rm ./*.deb

    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Clean up font files${CLEAR}"
    rm -r /tmp/fonts
    rm ./*.zip

    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Clean up apt packages${CLEAR}"
    sudo apt -y --purge autoremove
    sudo apt clean
    sudo apt autoclean

    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Clean up snap caches${CLEAR}"
    sudo sh -c 'rm -rf /var/lib/snapd/cache/*'
}

install-all() {
    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install basic tools${CLEAR}"
    install-basic-tools
    
    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install dev tools${CLEAR}"
    install-dev-tools

    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install personalizations${CLEAR}"
    install-personalize
    
    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install portainer (docker manage tool)${CLEAR}"
    install-portainer

    echo -e "\n${GREEN}${BOLD}POST SETUP ${BLUE}=> ${CYAN}Clean-Up${CLEAR}"
    clean-up
}

install-all
if [ "$1" != "--called-from-another" ]; then
    echo -e "\n${BLUE}${BOLD}=> ${WHITE}Install Complete! Restart your computer to continue!${CLEAR}"
else 
    echo -e "\n${BLUE}${BOLD}=> ${WHITE}Desktop Tool Install Complete!${CLEAR}\n"
fi