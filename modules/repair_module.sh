#!/usr/bin/env bash
# ==============================================================================
# Auto-Healing Repair Module Engine
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/tui.sh"

run_repair_module() {
    tui_banner
    log_section "Termux Bootstrap Self-Healing Repair System"

    local repair_scripts=(
        "${SCRIPT_DIR}/repair/repair_apt.sh"
        "${SCRIPT_DIR}/repair/repair_permissions.sh"
        "${SCRIPT_DIR}/repair/repair_symlinks.sh"
    )

    for r_script in "${repair_scripts[@]}"; do
        if [[ -f "${r_script}" ]]; then
            log_info "Executing repair workflow: $(basename "${r_script}")"
            bash "${r_script}" || log_warn "Repair script returned warning: $(basename "${r_script}")"
        fi
    done

    log_success "Termux Bootstrap self-healing repair routines complete."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_repair_module
fi
