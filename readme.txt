本工程采用CMake作为默认编译构建工具

Linux平台编译参考
================

1. 在本目录下执行 source build/envsetup.sh 选择相应的配置平台，（注意修改 build 目录下的编译器的路径配置）

2. 执行命令，根据不同平台,通过cmake生成Makefile, Makefile一旦生成，后续如果不增加或删除 *.c, *.h 文件，都不用再次执行步骤1和2
   cmake . (x86) 
   cmarm (arm), 
   cmjz (君正)

3. make即可

Android平台编译
===============

1. 切换到android/jni目录

2. ndk-build


