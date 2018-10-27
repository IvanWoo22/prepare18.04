#!/usr/bin/env bash

echo "====> Building Genomics related tools <===="
echo '==> It will take a lot of time and times.' 
echo "==> Trust me \"Updating Homebrew...\" will cost unbelievable time." && sleep 3


echo "==> anchr"
check_install () {
    if brew list --versions $1 > /dev/null; then
        echo "$1 already installed"
    else
        brew install $1;
    fi
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    check_install jdk
fi

for package in graphviz jq parallel pigz;
do
    check_install ${package}
done

for package in abyss fastqc samtools seqtk sickle;
do
    check_install ${package}
done

for package in minimap miniasm sga;
do
    check_install brewsci/bio/${package};
done

for package in bbtools poa ;
do
    check_install brewsci/science/${package};
done

for package in faops jrange jrunlist sparsemem dazz_db@20161112 daligner@20170203;
do
    check_install wang-q/tap/${package};
done

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    if brew list --versions jellyfish > /dev/null; then
        brew unlink jellyfish
    fi
    check_install wang-q/tap/jellyfish@2.2.4
    brew unlink jellyfish@2.2.4 && brew link jellyfish@2.2.4
    check_install wang-q/tap/quorum@1.1.1
    check_install wang-q/tap/superreads
fi


echo "==> other tools"
brew tap brewsci/bio
brew tap brewsci/science

brew install bowtie bowtie2 igvtools
brew install tophat cufflinks stringtie hisat2
brew install sratoolkit
brew install genometools --without-pangocairo
brew install canu
brew install kmergenie --with-maxkmer=200



echo "==> custom tap"
brew tap wang-q/tap
brew install multiz faops

mkdir -p $HOME/share/
mkdir -p $HOME/prepare18.04/resource

echo "==> trinity 2.0.6"
#brew install trinity
cd $HOME/prepare18.04/resource/
wget -N https://github.com/trinityrnaseq/trinityrnaseq/archive/v2.0.6.tar.gz

cd $HOME/share/
tar xvfz $HOME/prepare18.04/resource/v2.0.6.tar.gz

cd $HOME/share/trinityrnaseq-*
make
make plugins

echo "==> gatk 3.5"
# brew install maven

if [ ! -e $HOME/prepare18.04/resource/gatk-3.5.tar.gz ];
then
    cd $HOME/prepare18.04/resource/
    wget -N https://github.com/broadgsa/gatk-protected/archive/3.5.tar.gz

    cd $HOME/share/
    tar xvfz $HOME/prepare18.04/resource/3.5.tar.gz

    cd $HOME/share/gatk-protected-*
    # Compile the GATK but not Queue
    mvn verify -P\!queue
    mv target/executable $HOME/share/gatk

    cd $HOME/share
    tar cvfz gatk-3.5.tar.gz gatk
    mv gatk-3.5.tar.gz $HOME/prepare18.04/resource/
else
    cd $HOME/share/
    tar xvfz $HOME/prepare18.04/resource/gatk-3.5.tar.gz
fi

cd $HOME/share/
java -jar java -jar gatk/GenomeAnalysisTK.jar --help

echo "==> circos"
cd $HOME/prepare18.04/resource/
wget -N http://circos.ca/distribution/circos-0.69-6.tgz
wget -N http://circos.ca/distribution/circos-tools-0.22.tgz

cd $HOME/share/
rm -fr circos
tar xvfz $HOME/prepare18.04/resource/circos-0.69-6.tgz
mv circos-0.69-6 circos

sudo perl -pi -e 's{^#!\/bin\/env}{#!\/usr\/bin\/env}g' $HOME/share/circos/bin/circos
sudo perl -pi -e 's{^#!\/bin\/env}{#!\/usr\/bin\/env}g' $HOME/share/circos/bin/gddiag

ln -fs $HOME/share/circos/bin/circos $HOME/bin/circos

cd $HOME/share/
rm -fr circos-tools
tar xvfz $HOME/prepare18.04/resource/circos-tools-0.22.tgz
mv circos-tools-0.22 circos-tools