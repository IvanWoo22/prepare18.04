#!/usr/bin/env bash

wget https://data.qiime2.org/distro/core/qiime2-2018.8-py35-linux-conda.yml


echo '==> Installing Qiime2.'
conda env create -n qiime2-2018.8 --file qiime2-2018.8-py35-linux-conda.yml   > output.txt 2>&1

while  grep -q -i error $HOME/output.txt ;
do
    echo 'Try Again!'
    conda env create -n qiime2-2018.8 --file qiime2-2018.8-py35-linux-conda.yml  > output.txt 2>&1
done




# OPTIONAL CLEANUP
rm qiime2-2018.8-py35-linux-conda.yml
