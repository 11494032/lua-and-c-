#!/bin/sh

#
# build/envsetup.sh
#
# (c) Copyright 2015
# youxiaolong <2427706602@qq.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

function set_environment()
{
	# get the absolute
	TOPDIR=`pwd`

	# export the path
	export TOPDIR
	export OUTPUT_DIR=${TOPDIR}/output
	export ROBOT_DIR=${TOPDIR}/output/robot
	export PRELIB_DIR=${TOPDIR}/output/prelib
	export TARGET_DIR=${TOPDIR}/output/target

	# export lichee and linux path
	export LICHEE_DIR=${TOPDIR}/../lichee
	export LICHEE_LINUX=${LICHEE_DIR}/linux-3.0
	export PATH=$PATH
}

function build_help()
{
	echo "command list:"
	echo "board_config:"
	echo "    config the product board"
	echo "mkboot:"
	echo "    make bootloader"
	echo "mkkernel:"
	echo "    make linux kernel"
	echo "mkroot:"
	echo "    make rootfs"
	echo "mkimg:"
	echo "    make firmware image, output to ./output/"
	echo "buildfirmware:"
	echo "    excute the board_config,mkkernel,mkboot,mkroot,mkimg"
	echo "    with this command, build firware image just one command!"
	echo "cleanroot:"
	echo "    clean the rootfs builder"
	echo "cleankernel:"
	echo "    clean the linux kernel builder"
	echo "cleanboot:"
	echo "    clean the bootloader builder"
	echo "clean_all:"
	echo "    clean all builder just one command"
}

###########################################################

function jgrep()
{
    find . -name .repo -prune -o -name .git -prune -o  -type f -name "*\.java" -print0 | xargs -0 grep --color -n "$@"
}

function cgrep()
{
    find . -name .repo -prune -o -name .git -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -print0 | xargs -0 grep --color -n "$@"
}

function mgrep()
{
    find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -regextype posix-egrep -iregex '(.*\/Makefile|.*\/Makefile\..*|.*\.make|.*\.mak|.*\.mk)' -type f -print0 | xargs -0 grep --color -n "$@"
}

function cmgrep()
{
    find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -regextype posix-egrep -iregex '(.*\/CMakeLists.txt)' -type f -print0 | xargs -0 grep --color -n "$@"
}

function croot()
{
    cd ${TOPDIR}
}

function cout()
{
    cd ${OUTDIR}
}

function robotcmds()
{
    echo "==== robot define commands ===="
    echo "cgrep jgrep mgrep cout croot 同Android"
    echo "cmgrep     对当前目录下的所有的 CMakeLists.txt 进行grep操作"
    echo "cmarm      arm交叉编译"
    echo "cmjz       jz交叉编译"
    echo "cmclean    切换编译工具链时需要clean"
    echo "cexternal  切换external目录"
    echo "cjdplayer  切换apps/jdplayer目录"
    echo ""
}

function cmclean()
{
    rm CMakeFiles/ CMakeCache.txt cmake_install.cmake Makefile -rf
}

function cmarm()
{
    cmake -DCMAKE_TOOLCHAIN_FILE=${TOPDIR}/build/Toolchain-arm-linux.cmake
}

function cmandroid()
{
    cmake -DCMAKE_TOOLCHAIN_FILE=${TOPDIR}/build/Toolchain-android-eabi.cmake
}

function cmjz()
{
    cmake -DCMAKE_TOOLCHAIN_FILE=${TOPDIR}/build/Toolchain-jz-linux.cmake
}

# Clear this variable.  It will be built up again when the vendorsetup.sh
# files are included at the end of this file.
unset LUNCH_MENU_CHOICES
function add_lunch_combo()
{
    local new_combo=$1
    local c
    for c in ${LUNCH_MENU_CHOICES[@]} ; do
        if [ "$new_combo" = "$c" ] ; then
            return
        fi
    done
    LUNCH_MENU_CHOICES=(${LUNCH_MENU_CHOICES[@]} $new_combo)
}

# add the default one here
add_lunch_combo x86
add_lunch_combo arm
add_lunch_combo android
add_lunch_combo jz

function print_lunch_menu()
{
    local uname=$(uname)
    echo
    echo "You're building on" $uname
    echo
    echo "Lunch menu... pick a combo:"

    local i=1
    local choice
    for choice in ${LUNCH_MENU_CHOICES[@]}
    do
        echo "     $i. $choice"
        i=$(($i+1))
    done

    echo
}

function lunch()
{
    local answer

    if [ "$1" ] ; then
        answer=$1
    else
        print_lunch_menu
        echo -n "Which would you like? [full-eng] "
        read answer
    fi

    local selection=

    if [ -z "$answer" ]
    then
        selection=arm
    elif (echo -n $answer | grep -q -e "^[0-9][0-9]*$")
    then
        if [ $answer -le ${#LUNCH_MENU_CHOICES[@]} ]
        then
            selection=${LUNCH_MENU_CHOICES[$(($answer-1))]}
        fi
    elif (echo -n $answer | grep -q -e "^[^\-][^\-]*-[^\-][^\-]*$")
    then
        selection=$answer
    fi

    if [ -z "$selection" ]
    then
        echo
        echo "Invalid lunch combo: $answer"
        return 1
    fi

    echo "selection is:" $selection

#    case "$selection" in
#       x86) export ARCH=x86;;
#       arm) GDB=arm-linux-androideabi-gdb;;
#    esac

    export ARCH=$selection
    export OUTDIR=$TOPDIR/out/${PRODUCTOR}-${ARCH}
}

export PRODUCTOR=app


set_environment
lunch
