#!/bin/bash

cat << EOF
clang++
-std=c++11
-pthread
-Wall
-Wextra
-I/opt/ros/melodic/include
-I/home/eggerk/catkin_ws/devel/include
-I/usr/include/eigen3
-DENABLE_TIMING=TRUE
-DENABLE_STATISTICS=TRUE
-DNDEBUG
-mssse3
-mssse3
-std=c++11
-I/usr/include/python2.7
-I/usr/src/googletest/googletest/include
EOF

if [ ! -z $1 ] ; then
  # Catkin workspace provided.
  echo "-I$(realpath "$1")/devel/include"
  echo "-I$(realpath "$1")/install/include"
  find $(realpath "$1")/src -type d -name include | sed "s/^/-I/"
fi
