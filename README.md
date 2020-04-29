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

Run install script.

Shutdown virtual machine

Link the image repository you want your images in to the image_repo directory inside your workspace.
Do the same for the rootfs_source directory in your workspace, link it to the distro repo in the source folder.

To start working enter the command ctp_install_new_environement $name (ex. linaro-desktop)
It will copy a new makeimage file, for tracking your advancements.

From there if you want temper with the root file system, untar it in the rootfs_factory directory.
Mess with it all you want, for instance install .deb packages by moving them in the rootfs_factory directory
and execute the command ctp_extractdeb. The file will be installed in the rootfs binary directory.
You will end up with a postinst script you must adapt to modify the remote fs and not the / fs.

Once you want to publish a new version of the file system, in the roootfs_factory directory
type in ctp_storeandupdate_rootfs $name [major] (ex. linaro-desktop) //the major option increment the major version
of the filesystem and reset the minor version to 0.

Now to build a card to execute on you CubieTruck plus board enter the environement directory (ex. linaro-desktop)
type 
  ctp_cleanwsenv
  source ctp_configure [$target] (target = card-hdmi card-dp emmc-hdmi emmc-dp void=last built target) //you must 
  install an usb key and connect it during the configuration process.
  source ctp_maketarget (don't forget the source command as it will not work without it)
  
  just wait for it.
 
Your image to be burned is ready.


