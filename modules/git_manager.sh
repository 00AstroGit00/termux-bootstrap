#!/usr/bin/env bash
# ==============================================================================
# Git Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_git_manager() {
    log_section "Git Manager"

    log_info "Configuring Git environment defaults..."
    if command -v git >/dev/null 2>&1; then
        git config --global init.defaultBranch main 2>/dev/null || true
        git config --global pull.rebase false 2>/dev/null || true
        log_success "Git defaults configured successfully."
    else
        log_warn "Git is not installed yet."
    fi

    state_db_add_item "installed_modules" "git_manager"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_git_manager
fi
