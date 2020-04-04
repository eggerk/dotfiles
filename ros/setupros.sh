export ROSCONSOLE_FORMAT='${severity} ${time} ${node}] ${message}'

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

for folder in /home/eggerk/catkin_ws \
              /home/eggerk/work/catkin_ws; do
  if [ -d "$folder"/devel ] ; then
    export CATKIN_WS="$folder"
  fi
done

# ROS
# Assume melodic by default.
ROS_DISTRO="melodic"

setupros() {
  if [ "$SHELL" = "/bin/bash" ] ; then
    ROS_OPT_FILE="/opt/ros/${ROS_DISTRO}/setup.bash"
    ROS_DEVEL_FILE="${CATKIN_WS}/devel/setup.bash"
  else
    ROS_OPT_FILE="/opt/ros/${ROS_DISTRO}/setup.zsh"
    ROS_DEVEL_FILE="${CATKIN_WS}/devel/setup.zsh"
  fi
  if [ -f $ROS_DEVEL_FILE ]; then
      source $ROS_DEVEL_FILE
  elif [ -f $ROS_OPT_FILE ]; then
    source $ROS_OPT_FILE
  fi
}
setupros
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
