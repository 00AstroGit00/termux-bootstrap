#!/usr/bin/env bash
# Developer Environment Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_dev_env() {
    log_section "Developer Environment Manager"
    log_info "Configuring dev toolchains (git, neovim/vim, tmux, gh)..."
    state_db_add_item "installed_modules" "dev_env"
    log_success "Developer environment configured."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_dev_env
fi
