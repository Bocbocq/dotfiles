# Source Home Manager session vars (provides LD_LIBRARY_PATH etc.)
[ -f ~/.nix-profile/etc/profile.d/hm-session-vars.sh ] && \
  source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

# Databricks
export DATABRICKS_RUNTIME_VERSION="connect"

# uv
export PATH="/home/boc/.local/bin:$PATH"
