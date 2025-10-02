from argparse import Namespace
import subprocess
import sys

def start(args: Namespace) -> None:
  subprocess.Popen(
    [ "quickshell", "-c", "meshell" ],
    stdout=subprocess.DEVNULL,
    stderr=subprocess.DEVNULL,
    stdin=subprocess.DEVNULL,
  )

def stop(args: Namespace) -> None:
  subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "shell", "kill" ])

def restart(args: Namespace) -> None:
  stop(args)
  start(args)

def running(args: Namespace) -> None:
  output = subprocess.run(
    [ "qs", "ipc", "-c", "meshell", "show" ],
    capture_output=True,
    text=True,
  )

  if not output.stdout.startswith("No running instances"):
    print("Meshell is RUNNING.")
    sys.exit(0)
  else:
    print("Meshell is NOT RUNNING.")
    sys.exit(1)
