#!/usr/bin/env bash
# Containers & Proot Distro Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_containers_module() {
    log_section "Containers & proot-distro Manager"
    if [[ "${INSTALL_PROOT:-1}" -eq 1 ]]; then
        log_info "Evaluating proot-distro Linux guest environment..."
        if command -v proot-distro >/dev/null 2>&1; then
            log_info "proot-distro is installed."
        fi
        state_db_add_item "installed_modules" "containers"
        log_success "Containers module complete."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_containers_module
fi
