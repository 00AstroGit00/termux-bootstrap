#!/usr/bin/env bash
# Doctor Check: Termux Shared Storage
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

check_storage() {
    log_info "[Check] Termux Shared Storage Symlinks..."
    if [[ -d "$HOME/storage" ]]; then
        log_success "Shared Storage: ACCESSIBLE ($HOME/storage)"
        return 0
    else
        log_warn "Shared Storage: NOT INITIALIZED. Run 'termux-setup-storage' to grant access."
        return 0
    fi
}
check_storage
