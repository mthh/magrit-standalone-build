#! /bin/bash
sudo -H pip3 install https://github.com/pyinstaller/pyinstaller/archive/develop.zip
if [ ! -d "magrit" ];
then
    git clone https://github.com/mthh/magrit
fi
mkdir pyinstaller
if [ ! -f "node-v8.11.2-linux-x64.tar.xz" ];
then
   curl -O https://nodejs.org/dist/v8.11.2/node-v8.11.2-linux-x64.tar.xz
fi
if [ ! -f "nwjs-sdk-v0.31.1-linux-x64.tar.gz" ];
then
   curl -O https://dl.nwjs.io/v0.31.1/nwjs-sdk-v0.31.1-linux-x64.tar.gz
fi
cp Magrit.spec pyinstaller/Magrit.spec
cd magrit
cd magrit_app
tar xvf ../../node-v8.11.2-linux-x64.tar.xz
cd node-v8.11.2-linux-x64/
./bin/npm install topojson
cd ../..
sudo -H pip3 install -r requirements/common.txt
python3 setup.py build_ext --inplace
cd ../pyinstaller
pyinstaller --clean --noconfirm Magrit.spec
mv dist/Magrit/share/gdal/2.2/* dist/Magrit/share/gdal
rm -rf dist/Magrit/share/gdal/2.2/
cd ..
tar xvzf nwjs-sdk-v0.31.1-linux-x64.tar.gz
cp nwclientapp/* nwjs-sdk-v0.31.1-linux-x64
mkdir magrit_standalone
mv nwjs-sdk-v0.31.1-linux-x64/* magrit_standalone
rm -rf nwjs-sdk-v0.31.1-linux-x64/
mkdir magrit_standalone/Magrit
cp -r pyinstaller/* magrit_standalone/Magrit/

