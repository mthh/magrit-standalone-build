git clone https://github.com/mthh/magrit
git clone https://github.com/pyinstaller/pyinstaller
curl -O https://nodejs.org/dist/v8.11.2/node-v8.11.2-win-x64.zip
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
python pyinstaller.py --clean --onefile Magrit.spec
# mv Magrit/dist/Magrit/osgeo._gdal.pyd Magrit/dist/Magrit/_gdal.pyd
cp ../dlls/spatialindex_c.dll Magrit/dist/Magrit/
cp ../dlls/spatialindex-64.dll Magrit/dist/Magrit/
cd ..
