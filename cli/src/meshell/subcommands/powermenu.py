import subprocess
from argparse import Namespace


def toggle(args: Namespace) -> None:
  subprocess.run(["qs", "ipc", "-c", "meshell", "call", "power", "toggle"])


def show(args: Namespace) -> None:
  subprocess.run(["qs", "ipc", "-c", "meshell", "call", "power", "display", "true"])


def hide(args: Namespace) -> None:
  subprocess.run(["qs", "ipc", "-c", "meshell", "call", "power", "display", "false"])
