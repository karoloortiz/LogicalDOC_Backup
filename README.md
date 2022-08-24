# LogicalDOC_Backup
Utility Backup LogicalDOC_Backup

AFTER CLONING REPO:
- cloning submodules:
  - git submodule init 
  - git submodule update

# CREATING NEW REPO

SUBMODULE
- git submodule add https://github.com/karoloortiz/Delphi_Utils_Library.git src/boundaries/KLib/Delphi_Utils_Library
- git submodule add https://github.com/karoloortiz/Delphi_Async_Library.git src/boundaries/KLib/Delphi_Async_Library
- git submodule add https://github.com/karoloortiz/Delphi_FormUtils_Library.git src/boundaries/KLib/Delphi_FormUtils_Library
- git submodule add https://github.com/karoloortiz/Delphi_MySQL_Library.git src/boundaries/KLib/Delphi_MySQL_Library

LFS
- git lfs track bmp/icon.ico
