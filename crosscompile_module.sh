#!/bin/bash
 
export BASEDIR=$(pwd)

export OPENWRT_BUILDDIR=/home/pigster/carambola2
 
export STAGING_DIR=${OPENWRT_BUILDDIR}/staging_dir
 
export V8SOURCE=${OPENWRT_BUILDDIR}/build_dir/target-mips_34kc_uClibc-0.9.33.2/node-v0.10.17/deps/v8
 
export PREFIX=${STAGING_DIR}/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mips-openwrt-linux-
 
export LIBPATH=${STAGING_DIR}/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/lib/
 
# MIPS cross-compile exports
export CC=${PREFIX}gcc
export CXX=${PREFIX}g++
export AR=${PREFIX}ar
export RANLIB=${PREFIX}ranlib
export LINK=${PREFIX}g++
export CPP="${PREFIX}gcc -E"
export STRIP=${PREFIX}strip
export OBJCOPY=${PREFIX}objcopy
export LD=${PREFIX}g++
export OBJDUMP=${PREFIX}objdump
export NM=${PREFIX}nm
export AS=${PREFIX}as
export PS1="[${PREFIX}] \w$ "
 
export LDFLAGS='-Wl,-rpath-link '${LIBPATH}
 
export GYPFLAGS="-Dv8_use_mips_abi_hardfloat=false -Dv8_can_use_fpu_instructions=false"
 
export npm_config_arch=mips
# path to the node source that was used to create the cross-compiled version
export npm_config_nodedir=${OPENWRT_BUILDDIR}/build_dir/target-mips_34kc_uClibc-0.9.33.2/node-v0.10.17
 
if [ ! -d $(pwd)/mips_modules_17 ]
then
        mkdir $(pwd)/mips_modules_17
fi
 
cd mips_modules_17/
 
version=`npm view "$1" version`
 
npm install --target_arch=mips "$1"
 
if [ $? -eq 1 ]
then
    echo " "
    echo "Build of package for MIPS failed ! ! !"
    echo " "
    exit 0
else
    echo " "
    echo ""Build of package for MIPS finished ! ! !""
    echo " "
fi

