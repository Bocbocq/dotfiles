# Source Home Manager session vars (provides LD_LIBRARY_PATH etc.)
# NixOS system-managed HM uses /etc/profiles/per-user; fall back to ~/.nix-profile for standalone HM
_hm_vars="/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh"
[ -f "$_hm_vars" ] || _hm_vars="$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
[ -f "$_hm_vars" ] && source "$_hm_vars"
unset _hm_vars

# Databricks
export DATABRICKS_RUNTIME_VERSION="connect"

# uv
export PATH="/home/boc/.local/bin:$PATH"
