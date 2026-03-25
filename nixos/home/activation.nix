{lib, ...}: {
  home.activation.fixClaudePluginPermissions =
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -d "$HOME/.claude/plugins/marketplaces" ]; then
        find "$HOME/.claude/plugins/marketplaces" -name "*.sh" -exec chmod +x {} \;
      fi
    '';
}
