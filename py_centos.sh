#!/bin/bash

set -e

if [ -z $1 ] || [ -z $2 ]; then
    echo "set the prefix to install"
    echo "for example: $0 /usr/local/python2.7 /usr/local/python3.3"
    exit
fi

yum -y groupinstall "Development tools"
yum -y install zlib-devel
yum -y install bzip2-devel openssl-devel ncurses-devel
yum -y install mysql-devel
yum -y install libxml2-devel libxslt-devel
yum -y install unixODBC-devel
yum -y install sqlite sqlite-devel

echo 'alias shasum="sha1sum"' >> $HOME/.bashrc

wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
tar -xJf Python-2.7.6.tar.xz
cd Python-2.7.6
./configure --prefix=$1
make && make altinstall
cd ..

wget http://www.python.org/ftp/python/3.3.3/Python-3.3.3.tar.bz2
tar -xvjf Python-3.3.3.tar.bz2
cd Python-3.3.3
./configure --prefix=$2
make && make altinstall
cd ..

wget --no-check-certificate https://pypi.python.org/packages/source/d/distribute/distribute-0.7.3.zip#md5=c6c59594a7b180af57af8a0cc0cf5b4a
unzip distribute-0.7.3.zip
cd distribute-0.7.3
$1/bin/python2.7 setup.py install
$2/bin/python3.3 setup.py install
cd ..

wget --no-check-certificate https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.10.1.tar.gz#md5=3a04aa2b32c76c83725ed4d9918e362e
tar -xvzf virtualenv-1.10.1.tar.gz
cd virtualenv-1.10.1
$1/bin/python2.7 setup.py install
cd ..

wget --no-check-certificate https://pypi.python.org/packages/source/v/virtualenvwrapper/virtualenvwrapper-4.1.1.tar.gz#md5=f18f2c612b936583a8ec0f7114b6637e
tar -xvzf virtualenvwrapper-4.1.1.tar.gz
cd virtualenvwrapper-4.1.1
$1/bin/python2.7 setup.py install
cd ..

echo 'export WORKON_HOME=~/Envs' >> $HOME/.bashrc
echo 'export PATH=$PATH:'$1/bin >> $HOME/.bashrc
echo 'export PATH=$PATH:'$2/bin >> $HOME/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=$1/bin/python2.7" >> $HOME/.bashrc
#echo "export VIRTUALENVWRAPPER_PYTHON=$2/bin/python3.3" >> $HOME/.bashrc
. $HOME/.bashrc
mkdir -p $WORKON_HOME
echo "source $1/bin/virtualenvwrapper.sh" >> $HOME/.bashrc
#echo "source $2/bin/virtualenvwrapper.sh" >> $HOME/.bashrc
. $HOME/.bashrc


echo "source your bashrc then you can do: 'mkvirtualenv foo --python=python2.7'"
