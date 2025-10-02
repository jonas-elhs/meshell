from argparse import Namespace
import subprocess

def start(args: Namespace) -> None:
  subprocess.Popen(
    [ "quickshell", "-c", "meshell" ],
    stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL,
    stdin=subprocess.DEVNULL
  )

def stop(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "shell", "kill" ])

def restart(args: Namespace) -> None:
  stop(args)
  start(args)
