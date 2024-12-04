# dotfiles
Contains my configurations for programs.

## Chezmoi

https://www.chezmoi.io/

### Chezmoi config

Start with this file in `~/.config/chezmoi`:
```toml
[merge]
command = "nvim"
args = ["-d", "{{ .Destination }}", "{{ .Source }}", "{{ .Target }}"]

[data]
hidpi = true
main_screen = "DP-4"
external_screen = "HDMI-A-1"
default_resolution = "3840x2160"
mirror_resolution = "3840x2160"

default_git_email = "..."
work_git_email = "..."
```


## References
- [Introduction to vim and tmux](https://www.youtube.com/watch?v=5r6yzFEXajQ) ([slides](https://github.com/nicknisi/vim-workshop), [config](https://github.com/nicknisi/dotfiles))
- [Introduction to tiling window managers](https://www.youtube.com/watch?v=Api6dFMlxAA) ([slides](http://files.project21.ch/LinuxDays-Public/16FS-Expert.pdf), [config](https://github.com/Jereviendrai/tiling_window_managers))
- [i3 setup](https://www.youtube.com/watch?v=j1I63wGcvU4) (part 1/3) ([config](https://github.com/alexbooker/dotfiles/tree/ubuntu))
- [Custom keyboard layout](http://askubuntu.com/questions/482678/how-to-add-a-new-keyboard-layout-custom-keyboard-layout-definition/483026#483026)
