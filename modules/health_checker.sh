#!/usr/bin/env bash
# ==============================================================================
# Health Checker Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

run_health_checker() {
    log_info "Performing system health checks..."
    local ok=0

    # Internet check
    if ping -c 1 8.8.8.8 >/dev/null 2>&1 || curl -sI https://1.1.1.1 >/dev/null 2>&1; then
        log_success "Connectivity check: ONLINE"
    else
        log_warn "Connectivity check: OFFLINE or restricted"
        ok=1
    fi

    return ${ok}
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_health_checker
fi
