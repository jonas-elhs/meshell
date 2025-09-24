from argparse import Namespace
import subprocess

def toggle(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "bar", "toggle" ])
def show(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "bar", "display", "true" ])
def hide(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "bar", "display", "false" ])
