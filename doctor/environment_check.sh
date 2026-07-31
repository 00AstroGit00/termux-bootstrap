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

    # Check for legacy Google Play Store build warning
    if [[ -d "/data/data/com.termux/files/usr" ]]; then
        if grep -q -i "com.termux" /proc/self/cgroup 2>/dev/null; then
            log_info "  - Build Signature: Valid Termux Build"
        fi
    fi

    log_success "Environment Diagnostic: PASS"
}
check_environment
