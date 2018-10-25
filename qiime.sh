#!/usr/bin/env bash

echo '==> Installing Qiime2.'
conda update conda
wget https://data.qiime2.org/distro/core/qiime2-2018.8-py35-linux-conda.yml
conda env create -n qiime2-2018.8 --file qiime2-2018.8-py35-linux-conda.yml
# OPTIONAL CLEANUP
rm qiime2-2018.8-py35-linux-conda.yml
