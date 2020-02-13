#! /bin/zsh

export ROSCONSOLE_FORMAT='${severity} ${time} ${node}] ${message}'

function change_catkin_ws() {
  if [[ ! -z $1 ]] ; then
    PATH=`realpath $1`
    export CATKIN_FOLDER=$PATH
  else
    if [[ "$CATKIN_FOLDER" == "/home/eggerk/catkin_ws" ]] ; then
      export CATKIN_FOLDER=/home/${USER}/other_ckws/muma_ws
    else
      export CATKIN_FOLDER=/home/${USER}/catkin_ws
    fi
  fi
  export CATKIN_WS="$CATKIN_FOLDER"
  echo "Catkin workspace changed to $CATKIN_WS."
  source ~/.zshrc
}

function ckdebug() {
  catkin config --cmake-args \
      -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
      -DCMAKE_CXX_FLAGS=-fdiagnostics-color
}

function ckrelease() {
  catkin config --cmake-args \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
      -DCMAKE_CXX_FLAGS=-fdiagnostics-color
}

if [ -z "$CATKIN_FOLDER" ] ; then
  export CATKIN_FOLDER=/home/${USER}/catkin_ws
fi
export CATKIN_WS="$CATKIN_FOLDER"

# ROS
# Assume melodic by default.
ROS_DISTRO="melodic"

if [ "$SHELL" = "/bin/bash" ] ; then
  ROS_OPT_FILE="/opt/ros/${ROS_DISTRO}/setup.bash"
  ROS_DEVEL_FILE="${CATKIN_WS}/devel/setup.bash"
else
  ROS_OPT_FILE="/opt/ros/${ROS_DISTRO}/setup.zsh"
  ROS_DEVEL_FILE="${CATKIN_WS}/devel/setup.zsh"
fi
if [ -f $ROS_OPT_FILE ]; then
  source $ROS_OPT_FILE
  if [ -f $ROS_DEVEL_FILE ]; then
    source $ROS_DEVEL_FILE
  fi
fi
alias ckws='$CATKIN_WS'

function cbt() {
  if [[ -z $1 ]] ; then
    catkin build --this --no-deps
  else
    catkin build $@ --no-deps
  fi
}
function cbtl() {
  if [[ -z $1 ]] ; then
    catkin build --this --no-deps --no-status | less
  else
    catkin build $@ --no-deps --no-status | less
  fi
}
function cb() {
  if [[ -z $1 ]] ; then
    catkin build --this
  else
    catkin build $@
  fi
}
function ctt() {
  if [[ -z $1 ]] ; then
    catkin run_tests --this --no-deps
  else
    catkin run_tests $@ --no-deps
  fi
}
function cttl() {
  if [[ -z $1 ]] ; then
    catkin run_tests --this --no-deps --no-status | less
  else
    catkin run_tests $@ --no-deps --no-status | less
  fi
}

export GTEST_COLOR='yes'

export STATE_MACHINE_IPC_DIR_OVERRIDE="$XDG_RUNTIME_DIR"
