#!/bin/sh   
cat spl-git/PKGBUILD | sed '/_kernel_version_x32_full=/!b;c_kernel_version_x32_full="${_kernel_version_x32}-apparmor"' > spl-git/PKGBUILD.new
cat spl-git/PKGBUILD.new | sed '/_kernel_version_x64_full=/!b;c_kernel_version_x64_full="${_kernel_version_x64}-apparmor"' > spl-git/PKGBUILD   
rm spl-git/PKGBUILD.new
     

cat spl-git/spl.install | sed 's/_kernel_version_x32_full=/_kernel_version_x32=/' | sed '/_kernel_version_x32=/a\ \ \ \ _kernel_version_x32_full="${_kernel_version_x32}-apparmor"' > spl-git/spl.install.new
cat spl-git/spl.install.new | sed 's/_kernel_version_x64_full=/_kernel_version_x64=/' | sed '/_kernel_version_x64=/a\ \ \ \ _kernel_version_x64_full="${_kernel_version_x64}-apparmor"' > spl-git/spl.install
rm spl-git/spl.install.new
     
   
cat zfs-git/PKGBUILD | sed '/_kernel_version_x32_full=/!b;c_kernel_version_x32_full="${_kernel_version_x32}-apparmor"' > zfs-git/PKGBUILD.new
cat zfs-git/PKGBUILD.new | sed '/_kernel_version_x64_full=/!b;c_kernel_version_x64_full="${_kernel_version_x64}-apparmor"' > zfs-git/PKGBUILD   
rm zfs-git/PKGBUILD.new
     

cat zfs-git/zfs.install | sed 's/_kernel_version_x32_full=/_kernel_version_x32=/' | sed '/_kernel_version_x32=/a\ \ \ \ _kernel_version_x32_full="${_kernel_version_x32}-apparmor"' > zfs-git/zfs.install.new
cat zfs-git/zfs.install.new | sed 's/_kernel_version_x64_full=/_kernel_version_x64=/' | sed '/_kernel_version_x64=/a\ \ \ \ _kernel_version_x64_full="${_kernel_version_x64}-apparmor"' > zfs-git/zfs.install
rm zfs-git/zfs.install.new