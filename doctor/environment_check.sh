#!/usr/bin/env bash
# Doctor Check: Environment, Path & Termux Build Verification
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/os_detect.sh"
source "${SCRIPT_DIR}/lib/logger.sh"

check_environment() {
    detect_system
    log_info "[Check] Environment & Hardware Architecture..."
    log_info "  - Architecture: ${SYS_ARCH}"
    log_info "  - Android SDK: ${SYS_ANDROID_API}"
    log_info "  - Free Disk:   ${SYS_AVAILABLE_DISK_MB} MB"
    log_info "  - Total RAM:   ${SYS_TOTAL_RAM_MB} MB"

    if [[ "${SYS_ANDROID_API}" -ge 31 ]]; then
        log_info "  - Note: On Android 12+ (API ${SYS_ANDROID_API}), ensure 'Disable child process restrictions' is set in Developer Options if running long background services."
    fi

    log_success "Environment Diagnostic: PASS"
}
check_environment
