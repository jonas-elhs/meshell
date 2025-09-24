from argparse import Namespace
import subprocess

def pick(args: Namespace) -> None:
  copy_string = "true" if args.copy else "false"
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "colorpicker", "pick", args.format, copy_string ])
