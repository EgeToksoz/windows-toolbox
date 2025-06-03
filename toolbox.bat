@echo off
Title Windows Toolbox
pushd %CD%
cd /d %~dp0
echo list vol > "listvol.txt"
diskpart /s listvol.txt
del listvol.txt
:sel
echo Command - Description
echo capture	Capture an Windows installation
echo append	Append changes on saved Windows installation
echo apply	Apply a Captured Windows image to a Partition
echo esd	Convert ESD files to WIM files
echo boot	    Add .ini drivers to boot.wim file 
echo efi	    Mount the first partition of selected disk
echo mbp    Install Macbook Pro Drivers after installer completes
set /P sel= What do you want to do?
if %sel% == capture goto capture
if %sel% == append goto append
if %sel% == apply goto apply
if %sel% == esd goto esd
if %sel% == boot goto boot
if %sel% == efi goto efi
if %sel% == mbp goto mbp
if %sel% == e goto end

:boot
set /P WIM=Where is the boot.wim File: 
set /P MNT=Where is the Mount Destination: 
set /P DRV=Where is the Driver folder path: 

dism /mount-image /imagefile:%WIM% /index:1 /mountdir:%MNT%
dism /image:%MNT% /add-driver:%DRV% /recurse
dism /unmount-image /mountdir:%MNT% /commit
dism /mount-image /imagefile:%WIM% /index:2 /mountdir:%MNT%
dism /image:%MNT% /add-driver:%DRV% /recurse
dism /unmount-image /mountdir:%MNT% /commit
goto end
:capture
set /P CAP=Where will be the wim file go(ex: D:): 
set /P WIN=Where is the windows drive located: 
set /P NAM=What the name will be(This will be both the file name and image name): 
dism /Capture-Image /ImageFile:"%CAP%\%NAM%.wim" /CaptureDir:%WIN%\ /Name:%NAM% /compress:fast /bootable
goto end
:append
set /P CAP=Where will be the wim file go: 
set /P WIN=Where is the windows drive located: 
set /P NAM=What the name will be: 
DISM /Append-Image /imagefile:"%CAP%\%NAM%.wim" /capturedir:%WIN%\ /Name:%NAM% /bootable
goto end
:apply
set /P CAP=Where is the file located(full path): 
set /P WIN=Where is the windows drive located:
dism /get-wiminfo /wimfile:"%CAP%"
goto end
set /P IND=Choose the index number(if you appended it add +1 to times Append): 
dism /Apply-Image /ImageFile:"%CAP%" /Index:%IND% /ApplyDir:%WIN%\
:esd
set /P ESD=Where is the ESD File (full path): 
dism /get-wiminfo /wimfile:"%ESD%"
set /P IND=choose version you want to export: 
set /P EXP=Choose the Export Destination(full path): 
dism /export-image /sourceimagefile:"%ESD%" /sourceindex:%IND% /destinationimagefile:%EXP% /compress:max /checkintegrity
goto end
:efi
Echo list disk > "cp.txt"
diskpart /s cp.txt
del cp.txt
set /p disk=Choose the Disk to mount the EFI:
echo select disk %disk% > "cp.txt"
echo select partition 1 >> "cp.txt"
echo assign letter=S >> "cp.txt"
diskpart /s cp.txt
del cp.txt
goto end
:mbp
set /P WIN=Where is the windows drive located: 
set /P DRV=Where is the Driver folder path: 
dism /image:%WIN% /add-driver:%DRV% /recurse
goto end
:end
exit