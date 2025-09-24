from argparse import Namespace
import subprocess

def get(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "wallpaper", "get" ])

def set(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "wallpaper", "set", args.path ])

class Command:
  args: Namespace

  def __init__(self, args: Namespace) -> None:
    self.args = args

  def run(self) -> None:
    action = [ self.args.action, self.args.file ] if self.args.file != None else [ self.args.action ]

    subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "wallpaper", *action ])
