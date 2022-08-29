# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.backend.base import Window
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.dgroups import simple_key_binder
from libqtile import hook

import os
import subprocess

## Define startup routine
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

mod = "mod4"
terminal = "kitty" 

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    
    ## mimic xmonad bringing focus with this hotkey
    Key([mod], "Return", lazy.layout.swap_left(), desc="bring selected window to front"),

    ## Cycle among open windows
    Key([mod], "space", lazy.layout.next()),
    
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.swap_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.swap_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "i", lazy.layout.grow(), desc="Grow window"),
    Key([mod, "control"], "m", lazy.layout.shrink(), desc="Shrink window"),
    Key([mod, "control"], "n", lazy.layout.normalize(), desc="Reset window size"),
    Key([mod, "control"], "o", lazy.layout.maximize(), desc="Maximize window"),
    
    
    ## Convenience bindings
    Key([mod, "shift"], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    ## Custom Keybinds added by bb
    Key([mod], "d", lazy.spawn("dmenu_run"), desc="Start dmenu"),
    Key([mod], "f", lazy.spawn("firefox"), desc="Start firefox"),
]


groups = [
    Group("term", spawn=["kitty"], init=True),
    Group("www"),
    Group("dev"),
    Group("vm", spawn=["virt-manager"], init=True),
    Group("social", spawn=["discord", "spotify"], init=True),
    Group("priv"),
]

## bind keys to go to the group i want
## also bind keys so i can move windows between groups easy
for i, g in enumerate(groups):
    keys.append(Key([mod], str(i + 1), lazy.group[g.name].toscreen()))
    keys.append(Key(
        [mod, "shift"],
        str(i + 1),
        lazy.window.togroup(g.name), 
        lazy.group[g.name].toscreen()
    ))

##bind keys to cycle through my groups
keys.extend([
    Key([mod], "Tab", lazy.screen.toggle_group()),
    Key([mod, "shift"], "Tab", lazy.screen.next_group()),
])

## bind keys for screenshots
keys.extend([
    Key([mod], "s", lazy.spawn("flameshot screen -n 0 -c")),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui -c"))
])

layouts = [
    layout.MonadTall(
        margin=4,
        border_width=0,
    ),
]

widget_defaults = dict(
    font="sans",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

current_wallpaper = "~/.wallpaper/cafe.jpg"
current_py = "~/.wallpaper/python.png"
current_arch = "~/.wallpaper/arch.png"
screens = [
    Screen(
        top = bar.Bar([
            ## Add python image to bar cuz qtile
            widget.Image(filename=current_py, scale=True),

            ## Add groups to bar
            widget.GroupBox(
                highlight_method="line",
                hide_unused=True,
                block_highlight_text_color="#FFFFFF",
                highlight_color=["#7F00FF", "#AA98A9"],
            ),
            widget.Spacer(),

            widget.OpenWeather(
                location="Tyler",
                metric=False,
            ),
            widget.Systray(),
            widget.Clock(format="%d/%m/%y %a %H:%M", padding=16),
            widget.Image(filename=current_arch, scale=True, padding=8)
        ], 30, background="#5030BC"),
        wallpaper=current_wallpaper,
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
