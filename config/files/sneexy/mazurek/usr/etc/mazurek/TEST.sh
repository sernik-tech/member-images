#!/usr/bin/env bash

img=$(find "/home/ruben/Git/sernik-tech/member-images/config/files/sneexy/mazurek/usr/etc/mazurek/assets" -type f -print0 | shuf -z -n 1)

zenity --info --width=400 --height=280 --icon="face-smile-big" --title="Welcome to Mazurek" --text="These dialogs will give you the basic information on how to navigate around your system and customize it.\n\nPlease do remember that this is a <i>completely personalized</i> for the images' creator, and that most things here are also things that either aren't compatible with your system/setup or things you just do not want.\n\nYou can find the <a href='https://git.gay/sneexy/el-dotfiles'>same exact dotfiles used here</a> over in its respective repository."

zenity --info --width=400 --height=480 --icon="input-keyboard" --title="Keybinds" --text="We have keybinds. As usual.\n\n<b>For applications:</b>\n<b>⊞ Super + Enter</b> • Opens a terminal\n<b>⊞ Super + Control + F</b> • Open Dolphin file manager\n<b>⊞ Super + Control + B</b> • Opens Firefox web browser\n\n<b>For Hyprland:</b>\n<b>boobies</b> • boobies"

zenity --info --width=400 --height=250 --icon="$img" --ok-label="OK • mrrp meow :3 • rraawr x3" --title="That's all" --text="To see these messages again, run the script located at <i>/etc/mazurek/mazurek-first-time-messages.sh</i>.\n\n<a href='https://github.com/sernik-tech/member-images'>Sernik member-images repository</a>\n\nBy clicking the button below, you <b>100% fully agree</b> to trans rights, becoming a boykisser, owning at least 73 cats, snuggling your local dragons, destroying capitalism and eating your enemies.\n\n<small>Icon credits to <a href='https://www.ahnik.art/'>Ahnik</a></small>"
