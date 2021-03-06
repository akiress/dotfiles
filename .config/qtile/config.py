#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""Qtile configuration file (config.py)"""

# Import
import subprocess
import re

from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import bar, widget, hook, layout

widget_defaults = dict(
    font='terminus-font',
    fontsize=12,
    padding=3,
)


## Mapped commands
class Commands(object):
    dmenu = 'dmenu_run -i -b -p ">>>" -fn "-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1" \
        -nb purple -nf "#fff" -sb blue -sf "#fff"'
    screenshot = 'scrot -b -m "%Y-%m-%d_%T_%wx%h_scrot.png"'
    ranger = 'urxvt -name ranger -e ranger'
    mutt = 'urxvt -name mutt -e mutt -y'
    weechat = 'urxvt -name weechat -e weechat-curses'


## Keybinds
win = "mod4" # shiftuper
mod = "mod1" # alt
keys = [
    Key([mod], "j",
        lazy.layout.down()),
    Key([mod], "k",
        lazy.layout.up()),
    Key([mod, "shift"], "j",
        lazy.layout.move_down()),
    Key([mod, "shift"], "k",
        lazy.layout.move_up()),
    Key([mod, "control"], "j",
        lazy.layout.section_down()),
    Key([mod, "control"], "k",
        lazy.layout.section_up()),
    Key([mod, "shift"], "h",
        lazy.layout.move_left()),
    Key([mod, "shift"], "l",
        lazy.layout.move_right()),

    Key([mod, "control"], "l",
        lazy.layout.increase_ratio()),
    Key([mod, "control"], "h",
        lazy.layout.decrease_ratio()),
    Key([mod], "comma",
        lazy.layout.increase_nmaster()),
    Key([mod], "period",
        lazy.layout.decrease_nmaster()),

    Key([mod], "Tab",
        lazy.group.next_window()),
    Key([mod, "shift"], "Tab",
        lazy.group.prev_window()),
    Key([mod, "shift"], "Return",
        lazy.layout.rotate()),
    Key([mod, "shift"], "space",
        lazy.layout.toggle_split()),

    Key([mod], "w",
        lazy.to_screen(0)),
    Key([mod], "e",
        lazy.to_screen(1)),
    Key([mod], "Left",
        lazy.prevgroup()),
    Key([mod], "Right",
        lazy.nextgroup()),
    Key([mod], "space",
        lazy.nextlayout()),
    Key([mod], "c",
        lazy.window.kill()),
    Key([mod], "t",
        lazy.window.disable_floating()),
    Key([mod, "shift"], "t",
        lazy.window.enable_floating()),

    Key([win], "d",
        lazy.spawn(Commands.dmenu)),
    Key([mod], "Return",
        lazy.spawn('terminology')),
    Key([win], "s",
        lazy.spawn(Commands.screenshot)),
    Key([win], "f",
        lazy.spawn(Commands.ranger)),
    Key([win], "m",
        lazy.spawn(Commands.mutt)),
    Key([win], "w",
        lazy.spawn(Commands.weechat)),

    Key([mod, "shift"], "p",
        lazy.restart()),
    Key([mod, 'control'], 'q',
        lazy.shutdown()),
]

## Mouse
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())]

## Border
border = dict(order_normal='#808080', border_width=2,)

## Screens
screens = [
    Screen(top=bar.Bar([
        widget.GroupBox(urgent_alert_method='text', **widget_defaults),
        widget.WindowName(**widget_defaults),
        widget.CurrentLayout(**widget_defaults),
        widget.Clock('%H:%M:%S %d.%m.%Y', **widget_defaults), ], 24, ), ),
    Screen(top=bar.Bar([
        widget.GroupBox(urgent_alert_method='text', **widget_defaults),
        widget.WindowName(**widget_defaults),
        widget.Prompt(),
        widget.CurrentLayout(**widget_defaults), ], 24, ), ),
    Screen(top=bar.Bar([
        widget.GroupBox(urgent_alert_method='text', **widget_defaults),
        widget.WindowName(**widget_defaults),
        widget.Systray(**widget_defaults),
        widget.CurrentLayout(**widget_defaults),
        widget.Clock('%H:%M:%S %d.%m.%Y', **widget_defaults), ], 24, ), ),
]


def app_or_group(group, app):
    """ Go to specified group if it exists. Otherwise, run the specified app.
    When used in conjunction with dgroups to auto-assign apps to specific
    groups, this can be used as a way to go to an app if it is already
    running. """
    def f(qtile):
        try:
            qtile.groupMap[group].cmd_toscreen()
        except KeyError:
            qtile.cmd_spawn(app)
    return f


# Next, we specify group names, and use the group name list to generate an appropriate
# set of bindings for group switching.
groups = []

# throwaway groups for random stuff
for i in ['1', '2', '3', '4', '5']:
    groups.append(Group(i))
    keys.append(
        Key([mod], i, lazy.group[i].toscreen())
    )
    keys.append(
        Key([mod, win], i, lazy.window.togroup(i))
    )


groups.extend([
    Group('sublime', persist=False, layout='max', init=False,
        matches=[Match(wm_class=['Sublime2', 'sublime2'])]),
    Group('gvim', layout='max', init=False, persist=False,
        matches=[Match(wm_class=['Gvim', 'gvim'])]),
    Group('music', layout='max', persist=False, init=False,
        matches=[Match(wm_class=['Clementine', 'Viridian'])]),
    Group('chrome', layout='stack', persist=False, init=False,
        spawn='google-chrome',
        matches=[Match(wm_class=['google-chrome', 'Google-chrome'])]),
    Group('firefox', layout='stack', persist=False, init=False,
        spawn='firefox',
        matches=[Match(wm_class=['Firefox', 'Navigator'])]),
    Group('io', layout='pidgin', persist=False, init=False,
        matches=[Match(wm_class=['Pidgin'], role=['Buddy List'])]),
    Group('nx', persist=False, layout='max', init=False,
        matches=[Match(wm_class=['NXClient'])]),
    Group('mail', persist=False, layout='max',
        spawn='urxvt -name "mutt" -e mutt -y',
        matches=[Match(title=['mutt'])]),
    Group('files', persist=False, layout='max',
        spawn='urxvt -name "ranger" -e ranger',
        matches=[Match(title=['ranger', 'Ranger'])]),
    Group('admin', persist=False, layout='max',
        spawn='urxvt -name "admin"',
        matches=[Match(title=['admin'])]),
    Group('sublime', persist=False, layout='max',
        matches=[Match(wm_class=['sublime-text-3', 'Sublime-text-3'])]),
    Group('server', persist=False, layout='max',
        spawn='urxvt -name "server"',
        matches=[Match(title=['server'])]),
    Group('eclipse', persist=False, layout='max',
        matches=[Match(wm_class=['Eclipse', 'Eclipse'])])
])

#   Layouts Config
# -------------------

# Layout Theme
layout_theme = {
    "border_width": 2,
    "margin": 3,
    "border_focus": "#005F0C",
    "border_normal": "#555555"}

layouts = [
    layout.Max(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Stack(stacks=2, **layout_theme),
    layout.Tile(shift_windows=True, **layout_theme),

    # a layout just for gimp(stolen from tych0's config)
    layout.Slice('left', 192, name='gimp', role='gimp-toolbox',
        fallback=layout.Slice('right', 256, role='gimp-dock',
            fallback=layout.Stack(stacks=1, **layout_theme))), ]

# Automatically float these types. This overrides the default behavior (which
# is to also float utility types), but the default behavior breaks our fancy
# gimp slice layout specified later on.
floating_layout = layout.Floating(auto_float_types=[
    "notification",
    "toolbar",
    "splash",
    "dialog", ],
    **layout_theme)


@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True


@hook.subscribe.client_new
def idle_dialogues(window):
    if((window.window.get_name() == 'Search Dialog') or
      (window.window.get_name() == 'Module') or
      (window.window.get_name() == 'Goto') or
      (window.window.get_name() == 'IDLE Preferences')):
        window.floating = True


def is_running(process):
    s = subprocess.Popen(["ps", "axw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
        return False


def execute_once(process):
    if not is_running(process):
        return subprocess.Popen(process.split())


@hook.subscribe.startup
def runner():
    import subprocess
    # subprocess.Popen(['nitrogen', '--restore', '&'])
    subprocess.Popen(['hsetroot', '-solid', '#000000'])
    subprocess.Popen(['xsetroot', '-cursor_name', 'top_left_arrow'])

# vim: tabstop=4 shiftwidth=4 expandtab
