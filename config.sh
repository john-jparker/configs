#!/bin/sh
#####################################
#  Bash script that configuers a new 
#  linux host system (KDE NEON)
#####################################

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
bold=$(tput bold)
normal=$(tput sgr0)

echo "${GREEN}${bold}##changing theme..${NC}${normal}"
bash lookandfeeltool -a org.kde.breezedark.desktop

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "${GREEN}${bold}Updating..${NC}${normal}"
pkcon update -y 
flatpak update -y

echo "${GREEN}${bold}Installing GO..${NC}${normal}"
curl -OL https://go.dev/dl/go1.18.1.linux-amd64.tar.gz
tar -C /usr/local -xvf go1.18.1.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.profile
source ~/.profile

echo "${GREEN}${bold}Installing Rust..${NC}${normal}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
apt-get install rustc cargo -y

echo "${GREEN}${bold}Installing Node 17 & NPM yarn..${NC}${normal}"
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
apt-get install -y nodejs
curl -qL https://www.npmjs.com/install.sh | sh
npm install -g nodemon
npm install --global yarn

echo "${GREEN}${bold}Installing AWS CLI..${NC}${normal}"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

echo "${GREEN}${bold}Installing GCP CLI..${NC}${normal}"
apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
apt-get update && sudo apt-get install google-cloud-cli -y

echo "${GREEN}${bold}##Installing terraform CLI..${NC}${normal}"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && sudo apt-get install terraform

echo "${GREEN}${bold}##Installing kdenlive, krita, & Docker..${NC}${normal}"
apt-get install kdenlive krita docker -y

echo "${GREEN}${bold}##Installing blender, Inkscape, Blankets, easyssh, gnomeBoxes, godotengine, videodownloader Nixwriter..${NC}${normal}"
flatpak install flathub org.blender.Blender org.inkscape.Inkscape com.rafaelmardojai.Blanket com.github.muriloventuroso.easyssh org.gnome.Boxes org.godotengine.Godot io.atom.Atom com.github.unrud.VideoDownloader com.gitlab.adnan338.Nixwriter -y


echo "${GREEN}${bold}##downloading github projects to github dir..${NC}${normal}"
git clone https://github.com/trevor256/trevor256.com.git github/trevor256.com/
git clone https://github.com/trevor256/LinuxConfig.git github/LinuxConfig/
git clone https://github.com/trevor256/FileCodify.git github/FileCodify/
chmod -R 777 github


#xpen driver
echo "${GREEN}${bold}##Download & install xpen drivers?${NC}${normal}"
 if [ "$reply" = y -o "$reply" = Y ]
   then
      curl https://www.xp-pen.com/download/file/id/1949/pid/819/ext/deb.html -o xpen.deb
      dpkg -i xpen.deb
   else
      echo "${RED}${bold}xpen Driver not installed${NC}${normal}"
   fi


#NVIDIA driver
   echo -n "${RED}${bold}Install NVIDIA Driver?${NC}${normal} (y/n)"
   read reply
   if [ "$reply" = y -o "$reply" = Y ]
   then
      apt-get install nvidia-driver-510 -y
   else
      echo "${RED}${bold}NVIDIA Driver not installed${NC}${normal}"
   fi


echo "${GREEN}${bold}##Finishing up..${NC}${normal}"
rm xpen.deb
pkcon update -y
flatpak update -y


   echo -n "${RED}${bold}remove config.sh script?${NC}${normal} (y/n)"
   read reply
   if [ "$reply" = y -o "$reply" = Y ]
   then
      rm -- "$0"
      echo "${GREEN}${bold}config.sh script removed${NC}${normal}"
   else
      echo "${RED}${bold}config.sh script not removed${NC}${normal}"
   fi



    echo -n "${RED}${bold}reboot?${NC}${normal} (y/n)"
    read reply
    if [ "$reply" = y -o "$reply" = Y ]
    then
      #setting display settings to 2560x1440 164Hz..
        xrandr --output DP-2 --mode 2560x1440 --rate 164.06
        reboot
    else
       echo "${RED}${bold}stopped reboot${NC}${normal}"
    fi
