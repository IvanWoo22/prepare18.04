#!/usr/bin/env bash

echo '==> Installing Rstudio.'
conda install rstudio   > output1.txt 2>&1


while  grep -q -i error $HOME/output1.txt ;
do
    echo 'Try Again!'
    conda install rstudio   > output1.txt 2>&1
    y
done

