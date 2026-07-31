#!/usr/bin/env bash
# ==============================================================================
# Custom Installer Adapter: Termux Essentials Utility Suite
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_installer_essentials() {
    log_section "Custom Installer: Termux Essentials"

    if state_db_has_item "installed_installers" "termux-essentials"; then
        log_info "Termux Essentials already installed."
        return 0
    fi

    log_info "Installing core termux tools (termux-tools, tar, unzip, wget)..."
    if command -v pkg >/dev/null 2>&1; then
        pkg install -y termux-tools tar unzip wget || true
    fi

    state_db_add_item "installed_installers" "termux-essentials"
    log_success "Termux Essentials installer completed."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_installer_essentials
fi
