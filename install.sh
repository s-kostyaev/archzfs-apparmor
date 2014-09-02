#!/bin/sh
CURDIR=`pwd`
echo $CURDIR
if [ $# -eq 0 ]
then 
 echo "Usage:"
 echo "    install.sh [WORKDIR]"
 exit 1
fi
if [ -d $1 ]
then 
 cd $1
else
 mkdir -p $1
 cd $1
fi
echo "Updating linux package..."
pacman -S linux --noconfirm
echo "done"
echo "Clonning kernel repo..."
git clone https://github.com/seletskiy/arch-apparmor.git
echo "done"
cd arch-apparmor/linux-apparmor
echo "Creating kernel package..."
makepkg --asroot -s 
echo "done"
echo "Installing kernel..."
pacman -U linux-apparmor-*-x86_64.pkg.tar.xz --noconfirm
pacman -U linux-apparmor-headers-*-x86_64.pkg.tar.xz --noconfirm
echo "done"
cd ../..
echo "Clonning zfs repo..."
git clone https://github.com/demizer/archzfs.git
echo "done"
echo "Patching archzfs for apparmor..."
cp $CURDIR/apparmor.patch archzfs/
cp $CURDIR/zfs-debug.patch archzfs/
cp $CURDIR/edit-for-apparmor.sh archzfs/
cd archzfs/
patch -Np1 -i apparmor.patch
patch -Np1 -i zfs-debug.patch
./edit-for-apparmor.sh 
echo "done"
cd spl-utils-git
echo "Creating spl-utils-git package..."
makepkg --asroot -s
echo "done"
echo "Installing zfs-utils-git package..."
pacman -U spl-utils-git-*x86_64.pkg.tar.xz --noconfirm
echo "done"
cd ../spl-git
echo "Creating spl-git package..."
makepkg --asroot -s
echo "done"
echo "Installing spl-git..."
pacman -U spl-git-*x86_64.pkg.tar.xz --noconfirm
echo "done"
cd ../zfs-utils-git
echo "Creating zfs-utils-git package..."
makepkg --asroot -s
echo "done"
echo "Installing zfs-utils-git package..."
pacman -U zfs-utils-git-*x86_64.pkg.tar.xz --noconfirm
echo "done"
cd ../zfs-git
echo "Creating zfs-git package..."
makepkg --asroot -s
echo "done"
echo "Installing zfs-git..."
pacman -U zfs-git-*x86_64.pkg.tar.xz --noconfirm
echo "done"
cd ../..
echo "Collecting packages"
mkdir $CURDIR/pkg
cp `find -iname "*pkg.tar.xz"` -t $CURDIR/pkg
echo "done"
