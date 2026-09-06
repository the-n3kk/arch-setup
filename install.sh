#!/bin/bash

# Checking if is running in Repo Folder
if [[ ! "$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')" =~ ^arch-setup$ ]]; then
    echo "Run this script from it's root dir."
    exit
fi

sudo pacman -S --noconfirm archlinux-keyring
sudo sed -i 's/^#\{0,1\}ParallelDownloads.*$/ParallelDownloads = 20/' /etc/pacman.conf
sudo pacman -S --noconfirm --needed reflector git archinstall stow
sudo reflector -a 48 -c Poland -f 10 | sudo tee /etc/pacman.d/mirrorlist

#-------------------------------------------------------------------------
#               Packages
#-------------------------------------------------------------------------

paru -Syu "$(awk '{print}' ORS=' ' pkgs/paru.txt)"
sudo pacman -Syu "$(awk '{print}' ORS=' ' pkgs/pacman.txt)"


#-------------------------------------------------------------------------
#               Configs
#-------------------------------------------------------------------------

git clone git@github.com:J4mStuff/dotfiles.git ~/dotfiles && cd ~/dotfiles && stow .
