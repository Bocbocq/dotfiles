{lib, ...}: {
  home.activation.fixClaudePluginPermissions =
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      find "$HOME/.claude/plugins/marketplaces" -name "*.sh" -exec chmod +x {} \;
    '';
}
