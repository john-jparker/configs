#!/bin/bash
########################################
#  Author https://github.com/trevor256
#  script configs new system
#  Linux OS (KDE NEON)
########################################
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

echo "${GREEN}${bold} Updating..${NC}${normal}"
sudo pkcon update -y

echo "${GREEN}${bold} Installing GO..${NC}${normal}"
curl -OL https://go.dev/dl/go1.18.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.18.1.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >>~/.profile
. ~/.profile

echo "${GREEN}${bold} Installing Rust..${NC}${normal}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
sudo apt-get install rustc cargo -y

echo "${GREEN}${bold} Installing Node 17 & NPM yarn..${NC}${normal}"
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g nodemon yarn

echo "${GREEN}${bold} Installing AWS CLI..${NC}${normal}"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "${GREEN}${bold} Installing GCP CLI..${NC}${normal}"
sudo apt-get install apt-transport-https ca-certificates gnupg -y
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update -y && sudo apt-get install google-cloud-cli -y

echo "${GREEN}${bold} Installing Azure CLI..${NC}${normal}"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "${GREEN}${bold} Installing Terraform CLI..${NC}${normal}"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
        
echo "${GREEN}${bold} Installing kdenlive, ktorrent, krita, ffmpeg, build-essential, nmap, moc, moc-ffmpeg-plugin, vim, nvim, ktorrent
blender, libreoffice, discord, Inkscape, gnomeBoxes, godotengine, videodownloader, bootqt, libllvm6.0, Audacity, OBS, marktext..${NC}${normal}"
sudo apt-get install ffmpeg build-essential nmap moc moc-ffmpeg-plugin -y
sudo flatpak install flathub org.kde.ktorrent org.vim.Vim org.blender.Blender org.libreoffice.LibreOffice com.discordapp.Discord io.neovim.nvim com.github.marktext.marktext org.kde.kdenlive org.inkscape.Inkscape org.kde.krita org.gnome.Boxes com.valvesoftware.Steam org.godotengine.Godot com.github.unrud.VideoDownloader io.github.giantpinkrobots.bootqt org.audacityteam.Audacity com.obsproject.Studio -y

echo "${GREEN}${bold} Downloading github projects to github dir..${NC}${normal}"
git config --global user.name "trevor256"
git config --global user.email "256trevor@gmail.com"
git clone https://github.com/trevor256/trevor256.com.git github/trevor256.com/
git clone https://github.com/trevor256/LinuxConfig.git github/MyConfig/
git clone https://github.com/trevor256/FileCodify.git github/FileCodify/
git clone https://github.com/trevor256/erupt-0.2.git github/erupt-0.2/
git clone https://github.com/trevor256/AutoBlender.git github/AutoBlender/
git clone https://github.com/trevor256/trevdev-token github/trevdev-token/
git clone https://github.com/trevor256/MinecraftServer.git github/MinecraftServer/
chmod -R 777 github

echo "${GREEN}${bold} Install Xpen${NC}${normal}"
curl https://www.xp-pen.com/download/file/id/1949/pid/819/ext/deb.html -o xpen.deb
sudo dpkg -i xpen.deb
sudo rm xpen.deb go1.18.1.linux-amd64.tar.gz awscliv2.zip
lookandfeeltool -a 'org.kde.breezedark.desktop'

echo "${GREEN}${bold} install nvidia driver?${NC}${normal} (y/n)"
read -r reply
  if [ "$reply" = y ] || [ "$reply" = Y ]
   then
      sudo apt-get install nvidia-driver-510 -y
    else
       echo "${RED}${bold}  nvidia driver not installed${NC}${normal}"
    fi

echo "${GREEN}${bold} rebooting......${NC}${normal}"
sudo pkcon update -y
sudo reboot
    