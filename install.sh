#!/bin/sh
echo "Clonning kernel repo..."
git clone https://github.com/seletskiy/arch-apparmor.git
echo "done"
cd arch-apparmor/linux-apparmor
echo "Creating kernel package..."
makepkg
echo "done"
echo "Installing kernel..."
sudo pacman  --no-confirm -U linux-apparmor-*-x86_64.pkg.tar.xz
sudo pacman  --no-confirm -U linux-apparmor-headers-*-x86_64.pkg.tar.xz
echo "done"
cd ../..
echo "Clonning zfs repo..."
git clone https://github.com/demizer/archzfs.git
echo "done"
echo "Patching archzfs for apparmor..."
cp apparmor.patch archzfs/
cp edit-for-apparmor.sh archzfs/
cd archzfs/
patch -p1 -i apparmor.patch
./edit-for-apparmor.sh 
echo "done"
cd spl-git
echo "Creating spl-git package..."
makepkg
echo "done"
echo "Installing spl-git..."
sudo pacman  --no-confirm -U spl-git-*x86_64.pkg.tar.xz
echo "done"
cd ../zfs-git
echo "Creating zfs-git package..."
makepkg
echo "done"
echo "Installing zfs-git..."
sudo pacman  --no-confirm -U zfs-git-*x86_64.pkg.tar.xz
echo "done"
cd ../zfs-utils-git
echo "Creating zfs-utils-git package..."
makepkg
echo "done"
echo "Installing zfs-utils-git package..."
sudo pacman  --no-confirm -U zfs-utils-git-*x86_64.pkg.tar.xz
echo "done"
cd ../spl-utils-git
echo "Creating spl-utils-git package..."
makepkg
echo "done"
echo "Installing zfs-utils-git package..."
sudo pacman  --no-confirm -U spl-utils-git-*x86_64.pkg.tar.xz
echo "done"
cd ../..
echo "Collecting packages"
mkdir pkg
cp `find -iname "*pkg.tar.xz" .` pkg
echo "done"
