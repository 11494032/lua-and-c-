# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
SET(CMAKE_C_COMPILER   /ssd/z15_150804/lichee/buildroot/output/external-toolchain/bin/arm-none-linux-gnueabi-gcc)
SET(CMAKE_CXX_COMPILER /ssd/z15_150804/lichee/buildroot/output/external-toolchain/bin/arm-none-linux-gnueabi-g++)

# where is the target environment 
SET(CMAKE_FIND_ROOT_PATH /ssd/z15_150804/lichee/buildroot/output/external-toolchain)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
