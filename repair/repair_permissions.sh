#!/usr/bin/env bash
# Repair Handler: Permissions & File Guards
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

heal_permissions() {
    log_info "[Repair] Fixing file permissions and executable bits..."
    chmod +x "${SCRIPT_DIR}"/*.sh 2>/dev/null || true
    chmod +x "${SCRIPT_DIR}/doctor"/*.sh 2>/dev/null || true
    chmod +x "${SCRIPT_DIR}/repair"/*.sh 2>/dev/null || true
    chmod +x "${SCRIPT_DIR}/modules"/*.sh 2>/dev/null || true
    chmod +x "${SCRIPT_DIR}/installers"/*.sh 2>/dev/null || true
    chmod +x "${SCRIPT_DIR}/providers"/*.sh 2>/dev/null || true
    if [[ -d "$HOME/.ssh" ]]; then
        chmod 700 "$HOME/.ssh"
        chmod 600 "$HOME/.ssh/id_"* 2>/dev/null || true
    fi
    log_success "[Repair] Permissions heal completed."
}
heal_permissions
