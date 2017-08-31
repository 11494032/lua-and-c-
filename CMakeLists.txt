cmake_minimum_required (VERSION 2.8)

project (app)

#configure_file (
#  "${PROJECT_SOURCE_DIR}/config.h.in"
#  "${PROJECT_BINARY_DIR}/config.h"
# )

set(CMAKE_OUTPUT_DIR $ENV{OUTDIR}/)

set(CMAKE_BINARY_DIR ${PROJECT_SOURCE_DIR})

set(CMAKE_BUILD_TYPE "Release")
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O2 -Wall")
set(CMAKE_CXX_FLAGS "-DARCH-$ENV{ARCH} -DENVROBOT2")

include_directories(
    	${PROJECT_SOURCE_DIR}/include)

# added the common source files
aux_source_directory(${PROJECT_SOURCE_DIR}/src/ SRCS_APP)


#add_library(app ${SRCS_APP})

add_executable(app ${SRCS_APP})
TARGET_LINK_LIBRARIES( app
     lua
    pthread 
	m)

set_target_properties( app
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_OUTPUT_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_OUTPUT_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_OUTPUT_DIR}/bin"
)
