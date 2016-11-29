#!/usr/bin/env python
import os
import sys
import xml.etree.ElementTree as xmlet

catkin_ws = '/home/eggerk/catkin_ws/'

def createYcmFile(src_path, build_path):
  # print src_path, ' ', build_path
  with open ("ycm_extra_conf.py", "r") as myfile:
    data = myfile.read()
    data = data.replace("%%%BUILD_FOLDER_PATH%%%", build_path)
    ycm_path = src_path + ".ycm_extra_conf.py"
    text_file = open(ycm_path, "w")
    text_file.write(data)
    text_file.close()
    print '\t Created ycm file in ', ycm_path, '.'

def checkDir(dir_name):
  all_elements_in_dir = os.listdir(dir_name);

  # First check for package.xml.
  for e in all_elements_in_dir:
    new_path = dir_name + e
    if os.path.isfile(new_path) and e == 'package.xml':
      root = xmlet.parse(new_path).getroot()
      for child in root:
        if child.tag == 'name':
          build_path = catkin_ws + 'build/' + child.text
          build_exists = os.path.isdir(build_path)
          print '[FOUND]',  new_path, '-->', child.text, ('' if build_exists else '(NO BUILD DIRECTORY)')
          createYcmFile(dir_name, build_path)
          return

  # Now loop through all sub directories
  for e in all_elements_in_dir:
    new_path = dir_name + e
    if os.path.isdir(new_path):
      new_path = new_path + '/'
      checkDir(new_path)

checkDir(catkin_ws + 'src/')
