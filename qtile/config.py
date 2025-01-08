import os
import subprocess

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Screen
from libqtile.lazy import lazy
from libqtile import hook

mod = "mod4"
terminal = "kitty"
app_search = "rofi -show drun"


@hook.subscribe.startup_once
def autostart():
    """Runs an autostart script"""
    script = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call(script)


keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="make the current window fullscrteen",
    ),
    Key([mod], "q", lazy.window.kill(), desc="Close currently focused window"),
    Key(
        [mod],
        "Return",
        lazy.window.bring_to_front(),
        desc="Bring current window to front",
    ),
    Key([mod], "q", lazy.window.kill(), desc="Close currently focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Spawn a terminal"),
    Key([mod], "d", lazy.spawn(app_search)),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )

layouts = [
    layout.MonadTall(),
]

widget_defaults = dict(
    font="Hack",
    fontsize=24,
    padding=3,
)
extension_defaults = widget_defaults.copy()

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

screens = [
    Screen(
        wallpaper="~/.config/bg/bucci.png",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.GroupBox(
                    block_highlight_text_color="#d64f4d",
                    font="Hack",
                    highlight_method="block",
                    this_current_screen_border="#bbbbbb",
                ),
                widget.Spacer(),
                widget.Volume(),
                widget.Sep(),
                widget.Wlan(),
                widget.Sep(),
                widget.Memory(),
                widget.Sep(),
                widget.Battery(format="{char} {percent: 2.0%} {hour:d}:{min:02d}"),
                widget.Sep(),
                widget.Systray(icon_size=32),
                widget.Sep(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            36,
            background="#282c34",
        ),
    ),
]

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wmname = "LG3D"
