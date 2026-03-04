{pkgs, ...}: {
  home.packages = with pkgs; [
    python311
    uv
    poetry
    black
    isort
    python3Packages.flake8
    ruff
    basedpyright
  ];
}
