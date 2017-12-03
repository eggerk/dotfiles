#!/bin/bash

echo "30 black; 31 red; 32 green; 33 yellow; 34 blue; 35 magenta; 36 cyan; 37 light gray; 39 default"
for i in `seq 30 39`; do
  echo -e "\e[${i}mcolor ${i}\e[0m"
done

echo "90 dark gray; 91 light red; 92 light green; 93 light yellow; 94 light blue; 95 light magenta; 96 light cyan; 97 white"
for i in `seq 90 97`; do
  echo -e "\e[${i}mcolor ${i}\e[0m"
done
