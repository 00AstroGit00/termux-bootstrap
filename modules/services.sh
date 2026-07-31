#!/usr/bin/env bash
# ==============================================================================
# Termux Services Manager Module (Runit Engine)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_services_manager() {
    log_section "Termux Services Manager"

    if [[ "${ENABLE_TERMUX_SERVICES:-1}" -ne 1 ]]; then
        log_info "ENABLE_TERMUX_SERVICES disabled in config.env. Skipping."
        return 0
    fi

    log_info "Evaluating background services..."

    if command -v sv-enable >/dev/null 2>&1; then
        log_info "Enabling sshd service via sv-enable..."
        sv-enable sshd 2>/dev/null || true
        state_db_add_item "installed_modules" "services"
        log_success "Termux sshd service enabled."
    else
        log_warn "termux-services package not initialized yet. Skipping runit setup."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_services_manager
fi
