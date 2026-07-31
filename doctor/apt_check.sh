#!/usr/bin/env bash
# Doctor Check: APT Package System
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

check_apt() {
    log_info "[Check] APT Package Manager & Repositories..."
    if command -v pkg >/dev/null 2>&1 || command -v apt-get >/dev/null 2>&1; then
        log_success "APT Package Manager: PRESENT"
        return 0
    else
        log_error "APT Package Manager: MISSING"
        return 1
    fi
}
check_apt
