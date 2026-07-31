#!/usr/bin/env bash
# ==============================================================================
# Doctor Diagnostic Module Engine
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/tui.sh"

run_doctor_module() {
    tui_banner
    log_section "Termux Bootstrap Doctor Diagnostics"

    local checks=(
        "${SCRIPT_DIR}/doctor/network_check.sh"
        "${SCRIPT_DIR}/doctor/apt_check.sh"
        "${SCRIPT_DIR}/doctor/storage_check.sh"
        "${SCRIPT_DIR}/doctor/permissions_check.sh"
        "${SCRIPT_DIR}/doctor/environment_check.sh"
    )

    local passed=0
    local failed=0

    for chk in "${checks[@]}"; do
        if [[ -f "${chk}" ]]; then
            if bash "${chk}"; then
                (( passed++ )) || true
            else
                (( failed++ )) || true
            fi
        fi
    done

    log_section "Diagnostic Summary"
    log_info "Checks Passed: ${passed}"
    log_info "Checks Failed: ${failed}"

    if [[ ${failed} -eq 0 ]]; then
        log_success "System is fully operational with ZERO diagnostic issues."
        return 0
    else
        log_warn "Doctor found ${failed} potential issues. Run 'bootstrap repair' or './repair.sh' to resolve."
        return 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_doctor_module
fi
