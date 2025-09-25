from argparse import Namespace
import subprocess

def get(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "wallpaper", "get" ])

def set(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "wallpaper", "set", args.path ])
