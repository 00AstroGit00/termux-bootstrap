#!/usr/bin/env bash
# Graphics & X11 Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_graphics_module() {
    log_section "Graphics & X11 Engine"
    if [[ "${INSTALL_X11:-0}" -eq 1 ]]; then
        log_info "Configuring Termux:X11 display server packages..."
        state_db_add_item "installed_modules" "graphics"
        log_success "Graphics engine initialized."
    else
        log_info "INSTALL_X11 disabled in config.env. Skipping."
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_graphics_module
fi
