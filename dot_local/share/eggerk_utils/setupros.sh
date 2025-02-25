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

for folder in /home/eggerk/ros2_ws \
              /home/eggerk/work/ros2_ws; do
  if [ -d "$folder"/devel ] ; then
    export ROS_WS="$folder"
  fi
done

# ROS
# Assume humble by default.
ROS_DISTRO="humble"

setupros() {
  if [ "$SHELL" = "/bin/bash" ] ; then
    ROS_OPT_FILE="/opt/ros/${ROS_DISTRO}/setup.bash"
    ROS_DEVEL_FILE="${ROS_WS}/devel/setup.bash"
  else
    ROS_OPT_FILE="/opt/ros/${ROS_DISTRO}/setup.zsh"
    ROS_DEVEL_FILE="${ROS_WS}/devel/setup.zsh"
  fi
  if [ -f $ROS_OPT_FILE ]; then
    source $ROS_OPT_FILE
  fi
  if [ -f $ROS_DEVEL_FILE ]; then
      source $ROS_DEVEL_FILE
  fi
}
setupros

export GTEST_COLOR='yes'

export STATE_MACHINE_IPC_DIR_OVERRIDE="$XDG_RUNTIME_DIR"
