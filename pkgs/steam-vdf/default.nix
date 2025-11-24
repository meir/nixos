{
  lib,
  fetchFromGitHub,
  buildPythonApplication,
  setuptools,
  poetry-core,
  humanize,
  psutil,
  vdf,
  ...
}:

buildPythonApplication {
  pname = "steam-vdf-cli";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "mdeguzis";
    repo = "steam-vdf";
    rev = "2e07ddff6b965bfadd713af30618139c22cb6cfb";
    sha256 = "sha256-aKzkvL9v6J7/Msth5kCAnlpVjIjOyrAOGjxiiVoyvCQ=";
  };

  format = "pyproject";

  build-system = [
    setuptools
    poetry-core
  ];

  propagatedBuildInputs = [
    humanize
    psutil
    vdf
  ];

  meta = with lib; {
    description = "Steam VDF command-line tool";
    homepage = "https://github.com/mdeguzis/steam-vdf";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
