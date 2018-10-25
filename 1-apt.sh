#!/usr/bin/env bash

echo "====> Install softwares via apt <===="

echo "==> Disabling the release upgrader"
sudo sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades


echo "==> Switch to the NJU mirror"
# http://nju-mirror-help.njuer.org/ubuntu.html
cat <<EOF > list.tmp
# NJU MIRRORS
deb http://mirrors.nju.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.nju.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.nju.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb http://mirrors.nju.edu.cn/ubuntu bionic-security main restricted universe multiverse

EOF

if [ "$(whoami)" == 'vagrant' ]; then
    echo "==> Disable AppArmor"
    sudo service apparmor stop
    sudo update-rc.d -f apparmor remove
fi


echo "==> Disable whoopsie"
sudo service whoopsie stop


echo "==> Install linuxbrew dependences"
sudo apt  update
sudo apt -y upgrade
sudo apt -y install gnome-tweak-tool build-essential curl git m4 ruby texinfo
sudo apt -y install libbz2-dev zlib1g-dev
sudo apt -y install libcurl4-openssl-dev libexpat1-dev libncurses5-dev


echo "==> Install other software"
sudo apt -y install gawk csh parallel vim graphviz screen unzip xsltproc numactl
sudo apt -y install libdb-dev libreadline-dev libedit-dev
sudo apt -y install libgd-dev libxml2-dev


echo "==> Install gsl"
sudo apt -y install libgsl-dev


echo "==> Install gtk3"
sudo apt -y install libcairo2-dev libglib2.0-0 libglib2.0-dev libgtk-3-dev libgirepository1.0-dev
sudo apt -y install gir1.2-glib-2.0 gir1.2-gtk-3.0 gir1.2-webkit-3.0

echo "==> Install gtk3 related tools"
sudo apt -y install xvfb glade



# install mongodb and redis by apt
echo "==> Install mongodb"
sudo apt -y install mongodb

echo "==> Install redis"
sudo apt -y install redis-server




# Mysql will be installed separately.
# Remove system provided mysql package to avoid confusing linuxbrew.
echo "==> Remove system provided mysql"
sudo apt -y purge mysql-common


echo "==> Restore original sources.list"
if [ -e /etc/apt/sources.list.bak ]; then
    sudo rm /etc/apt/sources.list
    sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
fi


echo "====> Basic software installation complete! <===="

