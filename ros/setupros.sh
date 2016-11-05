export CATKIN_WS=/home/eggerk/catkin_ws

# ROS
source /opt/ros/kinetic/setup.zsh
source ~/catkin_ws/devel/setup.zsh
alias catkin_ws='cd $CATKIN_WS'

alias ckthis='catkin build --this --no-deps'
alias cktest='catkin run_tests --this --no-deps'
