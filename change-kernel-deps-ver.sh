#!/bin/sh
cur_ver=`pacman -Q linux | cut --delimiter=" " -f2`
sed -i 's/_kernel_version_x32=.*/_kernel_version_x32="'$cur_ver'"/g' spl-git/PKGBUILD
sed -i 's/_kernel_version_x64=.*/_kernel_version_x64="'$cur_ver'"/g' spl-git/PKGBUILD

sed -i 's/_kernel_version_x32=.*/_kernel_version_x32="'$cur_ver'"/g' spl-git/spl.install
sed -i 's/_kernel_version_x64=.*/_kernel_version_x64="'$cur_ver'"/g' spl-git/spl.install

sed -i 's/_kernel_version_x32=.*/_kernel_version_x32="'$cur_ver'"/g' zfs-git/PKGBUILD
sed -i 's/_kernel_version_x64=.*/_kernel_version_x64="'$cur_ver'"/g' zfs-git/PKGBUILD

sed -i 's/_kernel_version_x32=.*/_kernel_version_x32="'$cur_ver'"/g' zfs-git/zfs.install
sed -i 's/_kernel_version_x64=.*/_kernel_version_x64="'$cur_ver'"/g' zfs-git/zfs.install

