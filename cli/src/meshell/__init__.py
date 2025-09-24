from meshell.parser import parse_args

def main() -> None:
  parser, args = parse_args()

  if args.version:
    print("v1")
  elif "execute" in args:
    args.execute(args)
  else:
    parser.print_help()
