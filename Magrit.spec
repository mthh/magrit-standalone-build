# -*- mode: python -*-

block_cipher = None

def get_pandas_path():
	import pandas
	return pandas.__path__ [0]

a = Analysis(['..\\magrit\\magrit_app\\app.py'],
             pathex=['..\\magrit\\magrit_app\\', 'C:\\Users\\RIATE\\Desktop\\code\\pyinstaller\\Magrit'],
             binaries=[],
             datas=[],
             hiddenimports=['helpers'],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher)
			 
dict_tree = Tree(get_pandas_path(), prefix='pandas', excludes=['*.pyc'])
a.datas += dict_tree
a.binaries = filter(lambda x: 'pandas' not in x[0], a.binaries)

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
