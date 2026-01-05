if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway

    export LIBSEAT_BACKEND=seatd

    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
    export ELM_DISPLAY=wl
    export SDL_VIDEODRIVER=wayland

    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export _JAVA_AWT_WM_NONREPARENTING=1

    export QT_QPA_FONTDIR=/usr/share/fonts/TTF

    exec dbus-run-session sway
fi
