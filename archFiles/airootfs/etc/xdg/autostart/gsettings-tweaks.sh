# Set wallpaper
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/space.jpg
gsettings set org.gnome.desktop.background picture-uri-dark file:///usr/share/backgrounds/space.jpg

# Customize apps menu
gsettings set org.gnome.shell app-picker-layout "[{'gparted.desktop': <{'position': <0>}>, 'installer.desktop': <{'position': <1>}>, 'ping-pong-counter.desktop': <{'position': <2>}> 'org.gnome.Console.desktop': <{'position': <3>}>, 'shutdown.desktop': <{'position': <4>}>, 'reboot.desktop': <{'position': <5>}>}]"

# Pin apps to taskbar
gsettings set org.gnome.shell favorite-apps "['ping-pong-counter.desktop', 'gparted.desktop', 'installer.desktop']"

# Toggle dark mode
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Set tap-to-click on touchpad
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true