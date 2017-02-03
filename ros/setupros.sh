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

alias ckthis='catkin build --this --no-deps'
alias cb='ckthis'
alias cbl='ckthis --no-status | less'
alias cbd='catkin build --this'
alias cktest='catkin run_tests --this --no-deps'
alias ct='cktest'
alias ctl='ct --no-status | less'

alias muma1='cd ~/other_ckws/muma_ws/src/multiagent_mapping/'
alias muma2='cd ~/catkin_ws/src/maplab/'

function muma() {
  if [[ "$CATKIN_FOLDER" == "other_ckws/muma_ws" ]] ; then
    muma1
  else
    muma2
  fi
}
