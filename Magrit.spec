# -*- mode: python -*-
import os
import glob

block_cipher = None

def get_pandas_path():
	import pandas
	return pandas.__path__ [0]

def get_node_path():
	path = glob.glob('../magrit/magrit_app/*node?*')
	return Tree(path[0], prefix=os.path.split(path[0])[1])

a = Analysis(['../magrit/magrit_app/app.py'],
             pathex=['../magrit/magrit_app/', '../Magrit'],
             binaries=[],
             datas=[],
             hiddenimports=['helpers'],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher)

a.datas += Tree(get_pandas_path(), prefix='pandas', excludes=['*.pyc'])
a.binaries = filter(lambda x: 'pandas' not in x[0], a.binaries)
a.datas += Tree('../magrit/magrit_app/static', prefix='static')
a.datas += [('__init__.py', '../magrit/magrit_app/__init__.py', 'DATA')]
a.datas += get_node_path()

pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          exclude_binaries=True,
          name='Magrit',
          debug=True,
          strip=False,
          upx=True,
          console=True )
coll = COLLECT(exe,
               a.binaries,
               a.zipfiles,
               a.datas,
               strip=False,
               upx=True,
               name='Magrit')
