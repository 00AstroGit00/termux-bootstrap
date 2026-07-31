#!/usr/bin/env bash
# ==============================================================================
# Installer Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_installer_manager() {
    log_section "Installer Manager"

    log_info "Executing custom third-party installer manifest pipeline..."

    local installers=(
        "${SCRIPT_DIR}/installers/termux_essentials.sh"
        "${SCRIPT_DIR}/installers/termux_build_essential.sh"
        "${SCRIPT_DIR}/installers/termuxvoid.sh"
    )

    for inst in "${installers[@]}"; do
        if [[ -f "${inst}" ]]; then
            log_info "Running installer adapter: $(basename "${inst}")"
            bash "${inst}" || log_warn "Installer adapter failed: $(basename "${inst}")"
        fi
    done

    state_db_add_item "installed_modules" "installer_manager"
    log_success "Installer Manager execution complete."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_installer_manager
fi
