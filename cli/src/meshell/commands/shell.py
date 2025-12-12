import subprocess
import sys
from argparse import Namespace


def start(args: Namespace) -> None:
  command = ["quickshell", "-c", "meshell"]

  if args.sub_process:
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
  if is_running():
    subprocess.run(["qs", "ipc", "-c", "meshell", "call", "shell", "kill"])

  if args.all and is_running():
    stop(args)


def restart(args: Namespace) -> None:
  if is_running():
    stop(args)

  start(args)


def running(args: Namespace) -> None:
  if is_running():
    print("Meshell is RUNNING.")
    sys.exit(0)
  else:
    print("Meshell is NOT RUNNING.")
    sys.exit(1)


def is_running() -> bool:
  output = subprocess.run(
    ["qs", "ipc", "-c", "meshell", "show"],
    capture_output=True,
    text=True,
  )

  return not output.stdout.startswith("No running instances")
