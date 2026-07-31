#!/usr/bin/env bash
# Doctor Check: Network & DNS
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

check_network() {
    log_info "[Check] Network Connectivity & DNS Resolution..."
    if ping -c 1 8.8.8.8 >/dev/null 2>&1 || curl -sI --connect-timeout 5 https://1.1.1.1 >/dev/null 2>&1; then
        log_success "Network Connectivity: PASS"
        return 0
    else
        log_warn "Network Connectivity: FAIL / Offline mode active"
        return 1
    fi
}
check_network
