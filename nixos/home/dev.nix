{pkgs, ...}: {
  home.packages = with pkgs; [
    # Java (required for PySpark 4.1+)
    jdk17

    # Python
    python312
    uv
    poetry
    black
    isort
    python3Packages.flake8
    ruff
    basedpyright
    pyright
    mypy

    # Lua
    lua
    stylua
    lua-language-server
    luajitPackages.luarocks

    # Rust
    cargo

    # JavaScript
    nodejs
    prettier

    # Nix
    nixd
    alejandra
    statix
    deadnix

    # Markdown / common dev tools
    markdownlint-cli2
    markdown-toc
    marksman
  ];
}
