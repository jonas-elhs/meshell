from argparse import Namespace
import subprocess

def lock(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "lockscreen", "lock" ])
def unlock(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "lockscreen", "unlock" ])
