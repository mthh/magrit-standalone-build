git clone https://github.com/mthh/magrit
git clone https://github.com/pyinstaller/pyinstaller
curl -O https://nodejs.org/dist/v8.11.2/node-v8.11.2-win-x64.zip
curl -O https://dl.nwjs.io/v0.31.1/nwjs-v0.31.1-win-x64.zip
cp Magrit.spec pyinstaller/Magrit.spec
cd magrit
cd magrit_app
unzip ../../node-v8.11.2-win-x64.zip
cd node-v8.11.2-win-x64/
./npm.cmd install topojson
cd ../..
pip install -r requirements/common.txt
python setup.py build_ext --inplace
cd ../pyinstaller
python pyinstaller.py --clean --noconfirm Magrit.spec
cp ../dlls/spatialindex_c.dll Magrit/dist/Magrit/
cp ../dlls/spatialindex-64.dll Magrit/dist/Magrit/
cd ..
unzip nwjs-v0.31.1-win-x64.zip
cp nwclientapp/* nwjs-v0.31.1-win-x64
mkdir magrit_standalone
mv nwjs-v0.31.1-win-x64/* magrit_standalone
rm -rf nwjs-v0.31.1-win-x64/
cp -r pyinstaller/Magrit magrit_standalone/
mv magrit_standalone/nw.exe magrit_standalone/launch_magrit.exe
rm -rf *.zip
