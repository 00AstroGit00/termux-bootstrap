#!/usr/bin/env bash
# Doctor Check: File Permissions & Private Storage Safety
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

check_permissions() {
    log_info "[Check] File System Permissions & Sandbox Safety..."

    if [[ "$HOME" == *"/data/data/com.termux"* ]]; then
        log_success "App Sandbox Storage: PASS ($HOME)"
    else
        log_warn "App Sandbox Storage: Custom path detected ($HOME)"
    fi

    if [[ -x "${SCRIPT_DIR}/bootstrap.sh" ]]; then
        log_success "Script Execution Bits: PASS"
    else
        log_warn "Script Execution Bits: Executable permission missing"
    fi
}
check_permissions
