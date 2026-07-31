#!/usr/bin/env bash
# ==============================================================================
# Storage Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_storage_manager() {
    log_section "Storage Manager"

    if [[ -d "/data/data/com.termux/files/home" ]]; then
        if [[ ! -d "$HOME/storage" ]]; then
            log_info "Termux storage permission / symlinks not initialized."
            if command -v termux-setup-storage >/dev/null 2>&1; then
                log_info "Invoking termux-setup-storage..."
                termux-setup-storage || true
            fi
        else
            log_info "Termux shared storage symlinks detected."
        fi
    fi

    state_db_add_item "installed_modules" "storage_manager"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_storage_manager
fi
