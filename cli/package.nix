{
  lib,
  python3
}:
python3.pkgs.buildPythonApplication {
  pname = "meshell-cli";
  version = "1.0";
  src = ./.;
  pyproject = true;

  build-system = with python3.pkgs; [
    hatchling
    hatch-vcs
  ];

  pythonImportsCheck = [ "meshell" ];

  meta = {
    description = "The control program for meshell";
    homepage = "https://github.com/jonas-elhs/meshell";
    license = lib.licenses.gpl3Only;
    mainProgram = "meshell";
    platforms = lib.platforms.linux;
  };
}
