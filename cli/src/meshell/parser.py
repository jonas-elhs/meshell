import argparse

from meshell.subcommands import bar, powermenu, colorpicker, wallpaper, lockscreen
from meshell import shell

def parse_args() -> (argparse.ArgumentParser, argparse.Namespace):
  parser = argparse.ArgumentParser(prog="meshell", description="Meshell control script")
  parser.add_argument("-v", "--version", action="store_true", help="print the current version")

  subcommands = parser.add_subparsers(title="commands", metavar="COMMAND")

  # Shell
  subcommands.add_parser("start", help="start the shell").set_defaults(execute=shell.start)
  subcommands.add_parser("stop", help="stop the shell").set_defaults(execute=shell.stop)
  subcommands.add_parser("restart", help="restart the shell").set_defaults(execute=shell.restart)

  # Bar
  bar_parser = subcommands.add_parser("bar", help="control the bar")
  bar_subparsers = bar_parser.add_subparsers(title="actions", metavar="ACTION", required=True)

  bar_subparsers.add_parser("toggle", help="toggle the bar").set_defaults(execute=bar.toggle)
  bar_subparsers.add_parser("show", help="show the bar").set_defaults(execute=bar.show)
  bar_subparsers.add_parser("hide", help="hide the bar").set_defaults(execute=bar.hide)

  # Power Menu
  power_parser = subcommands.add_parser("power", help="control the power menu")
  power_subparsers = power_parser.add_subparsers(title="actions", metavar="ACTION")

  power_subparsers.add_parser("toggle", help="toggle the power menu").set_defaults(execute=powermenu.toggle)
  power_subparsers.add_parser("show", help="show the power menu").set_defaults(execute=powermenu.show)
  power_subparsers.add_parser("hide", help="hide the power menu").set_defaults(execute=powermenu.hide)

  # Color Picker
  picker_parser = subcommands.add_parser("pick", help="pick a color")
  picker_parser.set_defaults(execute=colorpicker.pick)
  picker_parser.add_argument("format", choices=["hex", "rgb", "hsl", "hsv"], help="format of picked color (hex, rgb, hsl, hsv)")
  picker_parser.add_argument("-c", "--copy", action="store_true", help="copy the color to clipboard")

  # Wallpaper
  wallpaper_parser = subcommands.add_parser("wallpaper", help="control the wallpaper")
  wallpaper_subparsers = wallpaper_parser.add_subparsers(title="actions", metavar="ACTION", required=True)

  wallpaper_subparsers.add_parser("get", help="get current wallpaper").set_defaults(execute=wallpaper.get)
  wallpaper_set_parser = wallpaper_subparsers.add_parser("set", help="set new wallpaper")
  wallpaper_set_parser.set_defaults(execute=wallpaper.set)
  wallpaper_set_parser.add_argument("path", action="store", help="path to the new wallpaper")

  # Lockscreen
  subcommands.add_parser("lock", help="lock the screen").set_defaults(execute=lockscreen.lock)
  subcommands.add_parser("unlock", help="unlock the screen").set_defaults(execute=lockscreen.unlock)
  
  return parser, parser.parse_args()
