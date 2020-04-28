# CubieTruck-Plus-devtools
set of extra tools to build and set the CubieTruck-Plus OS SDK

How to install a linaro desktop distribution:

First download VirtualBox https://www.virtualbox.org/
Then the Ubuntu 12.04.5 server install CD (we use the server edition because we don't GUI)
http://releases.ubuntu.com/12.04.5/

Create a new Virtual Machine, I called mine "CubieTruck_Plus_Linux_SDK"
Add it a 16Gio VHD image fixed size.

In configuration I set:
  Bidirectionel clipboard.
  #of CPU = 4 (useful to compile the kernel)
  PS/2 Mouse pointer
  
Start it with the Ubuntu iso file attached.

I baptised my server ctp-os-sdk

I use linaro as standard user (same as the board)

I also choose ext3 filesystem I case of problem I can access it in windows.

Once installation complete, add Virtualbox Guest Additions
if the guest addition don't mount then acces the disc via Windows Disk Manager and using Ext2Fsd tools.
Mount the guest addition iso the copy the content in the /media/cdrom folder.
Return to the machine and install the guest additions by running ./VBoxLinuxAdditions.run (don't forget chmod of course).

Install git to retraive the OS SDK.

Clone your favorite Github project:-)




