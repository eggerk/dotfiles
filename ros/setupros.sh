#! /bin/zsh

function change_catkin_ws() {
  if [[ ! -z $1 ]] ; then
    PATH=`realpath $1`
    export CATKIN_FOLDER=$PATH
  else
    if [[ "$CATKIN_FOLDER" == "/home/eggerk/catkin_ws" ]] ; then
      export CATKIN_FOLDER=/home/eggerk/other_ckws/muma_ws
    else
      export CATKIN_FOLDER=/home/eggerk/catkin_ws
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
  export CATKIN_FOLDER=/home/eggerk/catkin_ws
fi
export CATKIN_WS="$CATKIN_FOLDER"

# ROS
source /opt/ros/kinetic/setup.zsh
source ${CATKIN_WS}/devel/setup.zsh
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

alias muma1='cd ~/other_ckws/muma_ws/src/multiagent_mapping/'
alias muma2='cd ~/catkin_ws/src/maplab/'

function muma() {
  if [[ "$CATKIN_FOLDER" == "/home/eggerk/other_ckws/muma_ws" ]] ; then
    muma1
  else
    muma2
  fi
}
