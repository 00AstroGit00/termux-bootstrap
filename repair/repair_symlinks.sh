#!/usr/bin/env bash
# Repair Handler: Broken Symlinks Cleanup
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

heal_symlinks() {
    log_info "[Repair] Scanning and removing broken symlinks in $HOME/bin..."
    if [[ -d "$HOME/bin" ]]; then
        find "$HOME/bin" -type l ! -exec test -e {} \; -delete 2>/dev/null || true
    fi
    log_success "[Repair] Symlinks heal completed."
}
heal_symlinks
