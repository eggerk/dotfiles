#!/bin/bash

cat << EOF
-std=c++14
-pthread
-Wall
-Wextra
-xc++
-I/opt/ros/melodic/include
-I/home/eggerk/catkin_ws/devel/include
-I/usr/include/eigen3
-isystem
../llvm/include
-isystem
../llvm/tools/clang/include
-I
.
-I
./ClangCompleter
-isystem
./tests/gmock/gtest
-isystem
./tests/gmock/gtest/include
-isystem
./tests/gmock
-isystem
./tests/gmock/include
-I/opt/ros/melodic/include
-I/opt/ros/melodic/share/xmlrpcpp/cmake/../../../include/xmlrpcpp
-I/usr/include/eigen3
-I/usr/include/pcl-1.7
-I/usr/include/ni
-I/usr/include/vtk-6.2
-I/usr/include/freetype2
-I/usr/include/x86_64-linux-gnu/freetype2
-I/usr/include/x86_64-linux-gnu
-I/usr/lib/openmpi/include/openmpi/opal/mca/event/libevent2021/libevent
-I/usr/lib/openmpi/include/openmpi/opal/mca/event/libevent2021/libevent/include
-I/usr/lib/openmpi/include
-I/usr/lib/openmpi/include/openmpi
-I/usr/include/python2.7
-I/usr/include/jsoncpp
-I/usr/include/hdf5/openmpi
-I/usr/include/libxml2
-I/usr/include/tcl
-I/usr/include/pcl-1.8/
-DENABLE_TIMING=TRUE
-DENABLE_STATISTICS=TRUE
-DHAVE_OPENCV
-mssse3
EOF

if [ ! -z $1 ] ; then
  # Catkin workspace provided.
  echo "-I$(realpath "$1")/devel/include"
  echo "-I$(realpath "$1")/install/include"
  find $(realpath "$1")/src -type d -name include | sed "s/^/-I/"
fi
