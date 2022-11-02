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

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}AnyDesk${CLEAR}"
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Add repository${CLEAR}"
    sudo mkdir -p /etc/apt/trusted.gpg.d
    curl -fsSL https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/anydesk.gpg
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Update apt source list${CLEAR}"
    sudo apt update
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    sudo apt -y install anydesk

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Zerotier${CLEAR}"
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Add repository${CLEAR}"
    sudo mkdir -p /etc/apt/trusted.gpg.d
    curl -fsSL https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/zerotier.gpg
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/zerotier.gpg] https://download.zerotier.com/debian/$(lsb_release -cs) $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/zerotier.list > /dev/null
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Update apt source list${CLEAR}"
    sudo apt update
    echo -e "\n${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    sudo apt -y install zerotier-one

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}GIMP${CLEAR}"
    sudo apt -y install gimp
}

install-dev-tools() {
    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Gnome Keyring${CLEAR}"
    sudo apt -y install gnome-keyring

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
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download deb file${CLEAR}"
    curl -SL https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.31-1ubuntu22.04_amd64.deb --output mysql-workbench.deb
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    cp mysql-workbench.deb /tmp
    sudo apt -y install /tmp/mysql-workbench.deb

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

install-communtiy() {
    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Telegram Desktop${CLEAR}"
    sudo snap install telegram-desktop

    echo -e "\n${YELLOW}${BOLD}SOFTWARE ${BLUE}=> ${WHITE}Discord Canary${CLEAR}"
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Download deb file${CLEAR}"
    curl -SL https://discord.com/api/download/canary\?platform\=linux\&format=deb --output discore-canary.deb
    echo -e "${CYAN}${BOLD}STEP ${BLUE}=> ${WHITE}Install${CLEAR}"
    cp discore-canary.deb /tmp
    sudo apt -y install /tmp/discore-canary.deb
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
    
    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install community tools${CLEAR}"
    install-community

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