#!/usr/bin/env bash
# ==============================================================================
# Update Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_update_module() {
    log_section "Update Module"
    log_info "Checking for framework and repository updates..."

    if [[ -d "${SCRIPT_DIR}/.git" ]] && command -v git >/dev/null 2>&1; then
        git -C "${SCRIPT_DIR}" pull --rebase 2>/dev/null || log_warn "Git pull failed or branch clean."
    fi

    log_success "Update workflow completed."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_update_module
fi
