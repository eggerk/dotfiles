Configuration for a custom keyboard layout based on the US layout containing access to umlaut characters (äöü) by using `AltGr`+`a`/`o`/`u`.

Place `us_umlaut` file into `/usr/share/X11/xkb/symbols/` folder.
Adjust `evdev.xml` in `/usr/share/X11/xkb/rules/`.

Then run `sudo dpkg-reconfigure xkb-data` to update the data and reboot.

See http://askubuntu.com/questions/482678/how-to-add-a-new-keyboard-layout-custom-keyboard-layout-definition/483026#483026 for more details.
