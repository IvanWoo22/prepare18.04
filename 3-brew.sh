#!/usr/bin/env bash

echo '==> Install Linuxbrew'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

echo '==> Add Linuxbrew to PATH'
test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
test -r ~/.profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile

source ~/.bashrc
source ~/.profile

echo '==> Change a source of NJU'
cd "$(brew --repo)"
git remote set-url origin https://mirrors.nju.edu.cn/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.nju.edu.cn/homebrew-core.git
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.nju.edu.cn/homebrew-bottles' >> ~/.profile
source ~/.profile

brew update

echo '==> Try to install a package'
brew install hello


# perl
echo "==> Install Perl 5.28"
brew install perl

