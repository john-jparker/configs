#!/bin/bash
###################################################################
#  Author https://github.com/trevor256
#  script configs new home server
#  Linux OS (Debian)
#
#  Applications
#  PXE Server, torrent, docker, cockpit, samba file share,
###################################################################

# Adds green to echos
      GREEN="$(tput setaf 2)"
      NONE="$(tput sgr0)"

echo "${GREEN} Updating..${NC}"
      sudo add-apt-repository universe
      sudo apt update && sudo apt upgrade -y

# users and groups 
      adduser user1
      groupadd mygroup
      usermod -aG mygroup olivia  #make permitions on group

# Podman
      sudo apt install podman apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

podman run \
 --detach \
 --label "io.containers.autoupdate=registry" \
 --name myjellyfin \
 --publish 8096:8096/tcp \
 --rm \
 --user $(id -u):$(id -g) \
 --userns keep-id \
 --volume jellyfin-cache:/cache:Z \
 --volume jellyfin-config:/config:Z \
 --mount type=bind,source=/path/to/media,destination=/media,ro=true \
 docker.io/jellyfin/jellyfin:latest

# cockpit managment cockpit-selinux cockpit-networkmanager
      wget -qO - https://repo.45drives.com/key/gpg.asc | sudo gpg --dearmor -o /usr/share/keyrings/45drives-archive-keyring.gpg
      cd /etc/apt/sources.list.d
      sudo curl -sSL https://repo.45drives.com/lists/45drives.sources -o /etc/apt/sources.list.d/45drives.sources
      sudo apt update
      apt install cockpit cockpit-podman cockpit-navigator -y


# jellyfin 
      docker pull jellyfin/jellyfin
      mkdir /jellyconfig
      mkdir /jellycache
      docker compose up
#Torrent Server

sudo apt-get transmission-cli transmission-common transmission-daemon
sudo usermod -a -G debian-transmission owner

sudo apt install nvidia-driver ffmpeg -y
wget -O- https://repo.jellyfin.org/install-debuntu.sh | sudo bash

transmission-cli

nano /etc/ssh/sshd_config
PermitRootLogin

sudo mkdir /public /private
sudo printf "[public]
   comment = Public Folder
   path = /public
   writable = yes
   guest ok = yes
   guest only = yes
   force create mode = 775
   force directory mode = 775
[private]
   comment = Private Folder
   path = /private
   writable = yes
   guest ok = no
   valid users = @smbshare
   force create mode = 770
   force directory mode = 770
   inherit permissions = yes" >> /etc/samba/smb.conf
sudo groupadd smbshare
sudo chgrp -R smbshare /private/
sudo chgrp -R smbshare /public
sudo chmod 2770 /private/
sudo chmod 2775 /public