from argparse import Namespace
import subprocess
import sys

def start(args: Namespace) -> None:
  command = [ "quickshell", "-c", "meshell" ]

  if args.sub_process == True:
    try:
      subprocess.run(command)
    except KeyboardInterrupt:
      sys.exit(0)
  else:
    subprocess.Popen(
      command,
      stdout=subprocess.DEVNULL,
      stderr=subprocess.DEVNULL,
      stdin=subprocess.DEVNULL,
    )

def stop(args: Namespace) -> None:
  if is_running() == True:
    subprocess.run([ "qs", "ipc", "-c", "meshell", "call", "shell", "kill" ])

  if args.all == True and is_running() == True:
    stop(args)

def restart(args: Namespace) -> None:
  if is_running() == True:
    stop(args)

  start(args)

def running(args: Namespace) -> None:
  if is_running() == True:
    print("Meshell is RUNNING.")
    sys.exit(0)
  else:
    print("Meshell is NOT RUNNING.")
    sys.exit(1)

def is_running() -> bool:
  output = subprocess.run(
    [ "qs", "ipc", "-c", "meshell", "show" ],
    capture_output=True,
    text=True,
  )

  return not output.stdout.startswith("No running instances")
