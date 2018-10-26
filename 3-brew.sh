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

if grep -q -i PERL_528_PATH $HOME/.bashrc; then
      echo "==> .bashrc already contains PERL_528_PATH"
else 
      echo "==> Updating .bashrc with PERL_528_PATH..."
      PERL_528_BREW=$(brew --prefix)/Cellar/$(brew list --versions perl | sed 's/ /\//')
      PERL_528_PATH="export PATH=\"$PERL_528_BREW/bin:\$PATH\""
      BREW_SITE_PERL="export PERL5LIB=\"$(brew --prefix)/lib/perl5/site_perl:\$PERL5LIB\""
      echo '# PERL_528_PATH' >> $HOME/.bashrc
      echo $PERL_528_PATH    >> $HOME/.bashrc
      echo $BREW_SITE_PERL   >> $HOME/.bashrc
      echo >> $HOME/.bashrc
  
      # make the above environment variables available for the rest of this script
      eval $PERL_528_PATH
      eval $BREW_SITE_PERL
> fi

echo "==> Install CPANM"
curl -L https://cpanmin.us | perl - App::cpanminus
