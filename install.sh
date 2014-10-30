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
makepkg --skipinteg --asroot -s 
echo "done"
echo "Installing kernel..."
pacman -Ud linux-apparmor-*-x86_64.pkg.tar.xz --noconfirm
pacman -Ud linux-apparmor-headers-*-x86_64.pkg.tar.xz --noconfirm
echo "done"
cd ../..
echo "Clonning zfs repo..."
git clone https://github.com/demizer/archzfs.git
echo "done"
echo "Patching archzfs for apparmor..."
cp $CURDIR/apparmor.patch archzfs/
cp $CURDIR/edit-for-apparmor.sh archzfs/
cp $CURDIR/change-kernel-deps-ver.sh archzfs/
cd archzfs/
echo "Updating versions..."
NEW_VER=`pacman -Q linux | cut -d' ' -f2 | cut -f1 -d- `
NEW_REL=`pacman -Q linux | cut -d' ' -f2 | cut -f2 -d- `
sed -i 's/^AZB_KERNEL_ARCHISO_VERSION=.*$/AZB_KERNEL_ARCHISO_VERSION="'$NEW_VER'"/' conf.sh
sed -i 's/^AZB_KERNEL_ARCHISO_X32_PKGREL=.*$/AZB_KERNEL_ARCHISO_x32_PKGREL="'$NEW_REL'"/' conf.sh
sed -i 's/^AZB_KERNEL_ARCHISO_X64_PKGREL=.*$/AZB_KERNEL_ARCHISO_x64_PKGREL="'$NEW_REL'"/' conf.sh
sed -i 's/^AZB_BUILD=0/AZB_BUILD=1/' build.sh
./build.sh git update
echo "done"
patch -Np1 -i apparmor.patch
./edit-for-apparmor.sh 
./change-kernel-deps-ver.sh
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
