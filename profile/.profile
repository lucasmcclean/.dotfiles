export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

export WAYLAND_DISPLAY=wayland-0

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland
export GDK_BACKEND=wayland

export WLR_NO_HARDWARE_CURSORS=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec dbus-launch --exit-with-session Hyprland
fi
