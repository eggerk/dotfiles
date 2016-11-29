#! /bin/zsh

function change_catkin_ws() {
  if [[ "$CATKIN_FOLDER" == "catkin_ws" ]] ; then
    export CATKIN_FOLDER=catkin_ws_1
  else
    export CATKIN_FOLDER=catkin_ws
  fi
  export CATKIN_WS="/home/eggerk/$CATKIN_FOLDER"
  echo "Catkin workspace changed to $CATKIN_WS."
  source ~/.zshrc
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
alias cktest='catkin run_tests --this --no-deps'
