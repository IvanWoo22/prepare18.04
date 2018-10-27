#!/usr/bin/env bash

echo '==> During this process, you will get the latest Python3 and R' && sleep 3

echo '==> Downloading Miniconda3'
wget -N http://mirrors.nju.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh

echo '==> Installing Miniconda3'
sh Miniconda3-latest-Linux-x86_64.sh

rm Miniconda3-latest-Linux-x86_64.sh
echo '==> The install package is removed.'


echo '==> Change a source of NJU'
conda config --add channels https://mirrors.nju.edu.cn/anaconda/pkgs/main/ 
conda config --add channels https://mirrors.nju.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.nju.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.nju.edu.cn/anaconda/cloud/msys2/
conda config --add channels https://mirrors.nju.edu.cn/anaconda/cloud/bioconda/
conda config --add channels https://mirrors.nju.edu.cn/anaconda/cloud/menpo/
conda config --set show_channel_urls yes



conda install r
conda install rstudio
