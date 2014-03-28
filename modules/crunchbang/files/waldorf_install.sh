#! /bin/bash

sudo apt-get update
sudo apt-get upgrade

wget -c http://packages.crunchbang.org/waldorf-dev/crunchbang.key
sudo apt-key add crunchbang.key

sudo apt-get -f -y install xorg slim alsa-base volumeicon-alsa openbox openbox-themes openbox-xdgmenu obmenu gmrun suckless-tools tint2 conky-all terminator hal

sudo apt-get -f -y install geany nitrogen lxappearance gtk2-engines-murrine thunar firefox gksu hsetroot arandr

sudo apt-get -f -y install vlc evince gpicview abiword gnumeric gigolo gftp xchat synaptic gparted gimp catfish file-roller scrot gcalctool xscreensaver htop

sudo apt-get obapps slimconf compton-git xfce4

mkdir installed
cd installed

wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-configs_20130504-2_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-conky_0.01_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-cowpowers_0.03_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-exit_0.01_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-fortune_0.01_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-lock_0.01_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-metapackage_20130504-1_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-pipemenus_0.14_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-slim_0.05_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-tint2_0.01_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-vlc-fix_0.01_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/cb-welcome_0.06_all.deb

wget -c http://packages.crunchbang.org/waldorf/pool/main/crunchbang-icon-theme_20130502-1_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/crunchbang-wallpapers_1.0-1_all.deb

wget -c http://packages.crunchbang.org/waldorf/pool/main/gnome-icon-theme_3.4.0-2crunchbang2_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/waldorf-slim-theme_0.03_all.deb
wget -c http://packages.crunchbang.org/waldorf/pool/main/waldorf-ui-theme_0.07_all.deb

sudo dpkg -i --force-depends *.deb

sudo apt-get -f install

sudo dpkg-reconfigure xserver-xorg

sudo
cp -R /etc/skel/.[a-zA-Z0-9]* /home/jacob/

#sudo /etc/init.d/slim start
