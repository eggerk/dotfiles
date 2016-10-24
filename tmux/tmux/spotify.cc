#include <algorithm>
#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <sstream>
#include <string>

std::string exec(const char* cmd) {
    char buffer[128];
    std::string result = "";
    std::shared_ptr<FILE> pipe(popen(cmd, "r"), pclose);
    if (!pipe) throw std::runtime_error("popen() failed!");
    while (!feof(pipe.get())) {
        if (fgets(buffer, 128, pipe.get()) != NULL)
            result += buffer;
    }
    return result;
}

std::string erase(std::string in, char c) {
  for (auto it = in.begin(); (it = std::find(it, in.end(), c)) != in.end();) {
    it = in.erase(it);
  }
  return in;
}

std::string shrinkString(std::string in, size_t size) {
  if (in.size() > size) {
    std::string res = std::string(in.begin(), in.begin() + size - 1);
    res += "…";
    return res;
  }
  return in;
}

bool isProgramRunning(const std::string& name) {
  std::string all_processes = exec("ps -e");
  std::istringstream iss(all_processes);
  for (std::string process; std::getline(iss, process);) {
    std::string pid, e1, e2, process_name;
    std::istringstream line_iss(process);
    line_iss >> pid >> e1 >> e2 >> process_name;

    if (process_name == name) {
      return true;
    }
  }

  return false;
}

std::string getOutputFromSpotify() {
  if (!isProgramRunning("spotify")) {
    return "♫ -";
  }

  std::string command =
      "dbus-send --print-reply "
      "--type=method_call "
      "--session "
      "--dest=org.mpris.MediaPlayer2.spotify "
      "/org/mpris/MediaPlayer2 "
      "org.freedesktop.DBus.Properties.Get "
      "string:org.mpris.MediaPlayer2.Player "
      "string:Metadata";
  std::string reply_str = exec(command.c_str());
  std::istringstream reply(reply_str);
  std::string album = "";
  std::string artist = "";
  std::string title = "";

  std::string word = "";

  int state = -1;
  bool string_encountered = false;
  while (reply >> word) {

    if (word == "\"xesam:album\"") {
      state = 1;
      string_encountered = false;
    } else if (word == "\"xesam:artist\"") {
      state = 2;
      string_encountered = false;
    } else if (word == "\"xesam:title\"") {
      state = 3;
      string_encountered = false;
    } else if (word == "string") {
      string_encountered = true;
      continue;
    }

    if (string_encountered && state > 0) {
      switch (state) {
        case 1:
          album += word;
          album += " ";
          album = erase(album, '\"');
          break;
        case 2:
          artist += word;
          artist += " ";
          artist = erase(artist, '\"');
          break;
        case 3:
          title += word;
          title += " ";
          title = erase(title, '\"');
          break;
      }
      if (word.length() > 1 && word[word.length() - 1] == '\"') {
        string_encountered = false;
        state = -1;
      }
    } else {
      string_encountered = false;
    }
  }

  // Remove trailing space.
  if (album[album.length() - 1] == ' ') {
    album = std::string(album.begin(), album.end() - 1);
  }
  if (artist[artist.length() - 1] == ' ') {
    artist = std::string(artist.begin(), artist.end() - 1);
  }
  if (title[title.length() - 1] == ' ') {
    title = std::string(title.begin(), title.end() - 1);
  }
  album = shrinkString(album, 15u);
  title = shrinkString(title, 20u);
  artist = shrinkString(artist, 15u);

  std::stringstream result;
  result << "♫ " << title << " - " << artist;
  return result.str();
}

int main() { std::cout << getOutputFromSpotify(); }
