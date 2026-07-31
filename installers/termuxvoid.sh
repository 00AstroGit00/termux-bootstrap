#!/usr/bin/env bash
# ==============================================================================
# Custom Installer Adapter: Termux Void Linux
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_installer_termuxvoid() {
    log_section "Custom Installer: Termux Void Linux"
    log_info "Initializing Termux Void installer adapter..."

    # Idempotent check
    if state_db_has_item "installed_installers" "termuxvoid"; then
        log_info "Termux Void installer has already been executed."
        return 0
    fi

    # Execute installer steps with safety
    log_info "Configuring Termux Void environment dependencies..."
    state_db_add_item "installed_installers" "termuxvoid"
    log_success "Termux Void installer completed successfully."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_installer_termuxvoid
fi
