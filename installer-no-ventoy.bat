@echo off
Title Install Windows
call powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
pushd %CD%
cd /d %~dp0
Echo list vol > "lv.txt"
diskpart /s lv.txt
del lv.txt
set /p cleanuefi=Do you want to create partitions automatically or manually created them already (a)uto/(m)anual: 
cls
if %cleanuefi% == a goto auto
if %cleanuefi% == m goto manual
:auto
Echo list disk > "cp.txt"
diskpart /s cp.txt
del cp.txt
set /p disk=Choose the disk to create partitions on: 
set /p clean=Do you want this disk to be cleaned or create from unallocated space (c)lean/(u)nallocated: 
if %clean% == c goto conf
if %clean% == u goto part

:conf
set /p sure=Are you sure about this action this will delete all data on this drive (y/n): 
if %sure% == y goto clean
if %sure% == n goto part

:clean
echo select disk %disk% > "cp.txt"
echo clean >> "cp.txt"
echo convert gpt >> "cp.txt"
diskpart /s cp.txt
del cp.txt
cls
:part
set /p mini=Do you want the partitioning with windows standards or just efi and windows partition (f)ull/(m)ini: 
if %mini% == f goto full
if %mini% == m goto mini

:full
echo select disk %disk% > "cp.txt"
echo create partition efi size=300 >> "cp.txt"
echo format quick fs=fat32 >> "cp.txt"
echo assign letter=S >> "cp.txt"
echo create partition msr size=16 >> "cp.txt"
echo create partition primary size=600 >> "cp.txt"
echo format quick fs=ntfs >> "cp.txt"
echo assign letter=R >> "cp.txt"
echo set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac" >> "cp.txt"
echo gpt attributes=0x8000000000000001 >> "cp.txt"
echo create partition primary >> "cp.txt"
echo format quick fs=ntfs >> "cp.txt"
echo assign letter=W >> "cp.txt"
diskpart /s cp.txt
del cp.txt
goto cont
:mini
echo select disk %disk% > "cp.txt"
echo create partition efi size=300 >> "cp.txt"
echo format quick fs=fat32 >> "cp.txt"
echo assign letter=S >> "cp.txt"
echo create partition primary >> "cp.txt"
echo format quick fs=ntfs >> "cp.txt"
echo assign letter=W >> "cp.txt"
diskpart /s cp.txt
del cp.txt
goto cont

:manual
set /p mnt=Do you want to mount a partition. Partition Letter Will be L: (y/n): 
if %mnt% == y goto mount
if %mnt% == n goto cont
:mount
echo list vol > "listvol.txt"
diskpart /s listvol.txt
del listvol.txt
echo list disk > "mountdisk.txt"
diskpart /s "mountdisk.txt"
del mountdisk.txt
set /p disk=Which disk would you like to mount?: 
echo select disk %disk% > "listpar.txt"
Echo list par >> "listpar.txt"
diskpart /s listpar.txt
del listpar.txt
set /p partition=What partition would you like to mount?:
echo select disk %disk% >> "mountpart.txt"
echo select part %partition% >> "mountpart.txt"
echo assign letter=L >> "mountpart.txt"
diskpart /s mountpart.txt
del mountpart.txt
cls
:cont
cls
set /P image=Do you want to install from default .wim or from a captured image (d)efault/(c)ustom: 
if %image% == d goto installer
if %image% == c goto custom
cls
:installer
Echo list vol > "lv.txt"
diskpart /s lv.txt
del lv.txt
set /P WIN=Choose the Drive Letter for Windows Partition(ex: W:): 
cls
dism /get-wiminfo /wimfile:"\sources\install.wim"
set /P IND=Choose the Index Number from Selected File: 
dism /Apply-Image /ImageFile:"\sources\install.wim" /Index:%IND% /ApplyDir:%WIN%
cls
goto efi
:custom
Echo list vol > "lv.txt"
diskpart /s lv.txt
del lv.txt
set /P WIN=Choose the Drive Letter for Windows Partition(ex: W:): 
set /P CAP=Type full path for where custom .wim file is: 
cls
dism /get-wiminfo /wimfile:%CAP%
set /P IND=Choose the Index Number from Selected File: 
dism /Apply-Image /ImageFile:%CAP% /Index:%IND% /ApplyDir:%WIN%\
cls
:efi
Echo list vol > lv.txt"
diskpart /s lv.txt
del lv.txt
set /P EFI=Choose the Driver Letter for EFI Partition(ex: S:): 
bcdboot %WIN%\Windows /s %EFI% /f UEFI && bcdboot %WIN%\Windows /s %EFI% /f UEFI
popd