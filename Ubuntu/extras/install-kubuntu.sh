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
echo -e "${BLUE}${BOLD}=> ${WHITE}Extra config for Kubuntu${CLEAR}"

fix-zsh() {
    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Add Profile to ZProfile${CLEAR}"
    echo "emulate sh -c 'source /etc/profile'" | sudo tee -a /etc/zsh/zprofile > /dev/null

    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Fix nvm path for desktop app${CLEAR}"
    echo "export NVM_DIR=\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")" >> ~/.zprofile
    echo "[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\" # This loads nvm" >> ~/.zprofile
}

install-icons() {
    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Copy icons${CLEAR}"
    mkdir -p ~/.app/icons/
    cp icons/*  ~/.app/icons/

    echo -e "\n${YELLOW}${BOLD}STEP ${BLUE}=> ${WHITE}Replace vscode icon${CLEAR}"
    cp /usr/share/applications/code.desktop ~/.local/share/applications/
    sed -i "s/com.visualstudio.code/\/home\/$(whoami)\/.app\/icons\/com.visualstudio.code.png/g" ~/.local/share/applications/
}

install-all() {
    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Fix Z-Shell for Kubuntu${CLEAR}"
    fix-zsh

    echo -e "\n${GREEN}${BOLD}SETUP ${BLUE}=> ${CYAN}Install Icons${CLEAR}"
    install-icons
}

install-all

echo -e "\n${BLUE}${BOLD}=> ${WHITE}Extra config for Kubuntu Install Complete!${CLEAR}\n"
