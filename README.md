# 💻 Windows Installation and Utility Toolbox 

### Installer's Features
- Holds your hand during the installation process
- Skip Windows Hardware Checks
- Deploy computers in minutes
- Fully Supports and Embraces Ventoy with drag & drop bat file available
- Being able to choose different partition maps for installation 

	Full (Recommended Windows Partition Layout)
	
	Mini (Just the EFI and Primary Windows Partition)
- Installing from a custom WIM file as easy and fast as possible
- No EFI muckery like the official way like efi on one disk and windows on other disk in the computer
- Speedrun levels of speed it's a TAS but Glitchless%

### Toolbox Features
- ESD to WIM Convert

	Having multiple language iso with smaller size 
- Adding Drivers to WIM Files

	Making it easier to add drivers to wim files which is preferable on special hardware
- DISM Triplet

	You can do Capture, Append and Applying of WIM files from one place 
- Mounting EFI

	Windows or WinPE doesn't mount EFI partitions automatically now it's 2 key presses away
### TO-DO
- [ ] Renaming Prompts
- [ ] Localization 

## A little bit of backstory

This was a passion project of mine which started more than a year ago when i had to drop off my macbook to fix the plague of butterfly keyboard and there is a chance that they can reset the laptop for testing or just changing the logic board because of touch id mismatch (which happened 2 times). Which can result in lost data or lost settings and applications that have to be redownloaded. I tried mac specific solutions like Winclone but it was never stable (macos and ntfs what a great story blabla) enough for me to use it on a daily machine.

Now that i know i'm on my own i started to learn how to make backup of a windows partition then i stumbled upon another shortcoming of this t2 chip is no drivers = no keyboard/trackpad and at the time i had 2 usb hub with no usb-c flash drive so i find a way to inject those drivers at windows installer image.

And i said to myself if i want to create the ultimate toolbox wouldn't it be better if itsn't just 1 version of windows with 1 language and i added that feature and 1 year later it finally evolved to something i can comfortably use to install quickly(i mean QUICK) and now i'm sharing it as open source to make this into something amazing with full multi language support and it can save time from all our lives 😁
