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
alias cb='ckthis'
alias cbl='ckthis --no-status | less'
alias cbd='catkin build --this'
alias cktest='catkin run_tests --this --no-deps'
alias ct='cktest'
alias ctl='ct --no-status | less'

alias muma1='cd ~/catkin_ws_1/src/multiagent_mapping/'
alias muma2='cd ~/catkin_ws/src/multiagent_mapping2/'

function muma() {
  if [[ "$CATKIN_FOLDER" == "catkin_ws" ]] ; then
    muma2
  else
    muma1
  fi
}
