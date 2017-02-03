#! /bin/zsh

function change_catkin_ws() {
  if [[ "$CATKIN_FOLDER" == "catkin_ws" ]] ; then
    export CATKIN_FOLDER=other_ckws/muma_ws
  elif [[ "$CATKIN_FOLDER" == "other_ckws/muma_ws" ]] ; then
    export CATKIN_FOLDER=other_ckws/tango_ws
  else
    export CATKIN_FOLDER=catkin_ws
  fi
  export CATKIN_WS="/home/eggerk/$CATKIN_FOLDER"
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
  export CATKIN_FOLDER=catkin_ws
fi
export CATKIN_WS="/home/eggerk/$CATKIN_FOLDER"

# ROS
source /opt/ros/kinetic/setup.zsh
source ${CATKIN_WS}/devel/setup.zsh
alias ckws='$CATKIN_WS'

function cb() {
  if [[ -z $1 ]] ; then
    catkin build --this --no-deps
  else
    catkin build $1 --no-deps
  fi
}
function cbl() {
  if [[ -z $1 ]] ; then
    catkin build --this --no-deps --no-status | less
  else
    catkin build $1 --no-deps --no-status | less
  fi
}
function cbd() {
  if [[ -z $1 ]] ; then
    catkin build --this
  else
    catkin build $1
  fi
}
function ct() {
  if [[ -z $1 ]] ; then
    catkin run_tests --this --no-deps
  else
    catkin run_tests $1 --no-deps
  fi
}
function ctl() {
  if [[ -z $1 ]] ; then
    catkin run_tests --this --no-deps --no-status | less
  else
    catkin run_tests $1 --no-deps --no-status | less
  fi
}

alias muma1='cd ~/other_ckws/muma_ws/src/multiagent_mapping/'
alias muma2='cd ~/catkin_ws/src/maplab/'

function muma() {
  if [[ "$CATKIN_FOLDER" == "other_ckws/muma_ws" ]] ; then
    muma1
  else
    muma2
  fi
}
