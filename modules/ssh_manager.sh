#!/usr/bin/env bash
# ==============================================================================
# SSH Manager Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/state_db.sh"

run_ssh_manager() {
    log_section "SSH Manager"

    local ssh_dir="$HOME/.ssh"
    mkdir -p "${ssh_dir}"
    chmod 700 "${ssh_dir}"

    if [[ ! -f "${ssh_dir}/id_ed25519" ]]; then
        log_info "Generating default SSH ed25519 keypair..."
        if command -v ssh-keygen >/dev/null 2>&1; then
            ssh-keygen -t ed25519 -N "" -f "${ssh_dir}/id_ed25519" -C "termux-bootstrap@local" >/dev/null 2>&1 || true
            log_success "Generated SSH key at ${ssh_dir}/id_ed25519"
        fi
    else
        log_info "SSH keypair already present."
    fi

    state_db_add_item "installed_modules" "ssh_manager"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_ssh_manager
fi
