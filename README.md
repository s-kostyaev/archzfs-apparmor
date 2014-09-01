archzfs-apparmor
=============

This script build and install arch-apparmor kernel (https://github.com/seletskiy/arch-apparmor)
and archzfs (https://github.com/demizer/archzfs) and collect all result packages in pkg/

Only for x86_64

--------------------------
How to use this Repository
--------------------------

Just run install.sh


--------------------------
How does it works
--------------------------

Install script download kernel from https://github.com/seletskiy/arch-apparmor

Then script build packages and install kernel and headers.

After that script download archzfs from https://github.com/demizer/archzfs

Then archzfs get patched for apparmor kernel

After that packages are built and installed in order dependencies

Finally all created packages are collected to pkg/
