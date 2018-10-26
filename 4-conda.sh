#!/usr/bin/env bash

echo '==> During this process, you will get the latest python3.' && sleep 3

echo '==> Downloading Miniconda3.'
wget -N http://mirrors.nju.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh

echo '==> Installing Miniconda3.'
sh Miniconda3-latest-Linux-x86_64.sh

rm Miniconda3-latest-Linux-x86_64.sh
echo '==> The install package is removed.'


