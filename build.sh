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
cp Magrit.spec pyinstaller/Magrit.spec
cd magrit
cd magrit_app
tar xvf ../../node-v8.11.2-linux-x64.tar.xz
cd node-v8.11.2-linux-x64/
./bin/npm install topojson electron@latest
cd ../..
sudo -H pip3 install -r requirements/common.txt
python3 setup.py build_ext --inplace
cd ../pyinstaller
pyinstaller --clean --noconfirm Magrit.spec
mv dist/Magrit/share/gdal/2.2/* dist/Magrit/share/gdal
rm -rf dist/Magrit/share/gdal/2.2/
cd ..
mkdir magrit_standalone
cp electronclientapp/* magrit_standalone/
mkdir magrit_standalone/Magrit
cp -r pyinstaller/* magrit_standalone/Magrit/
