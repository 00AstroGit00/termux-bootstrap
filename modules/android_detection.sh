#!/usr/bin/env bash
# ==============================================================================
# Android Detection Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/os_detect.sh"
source "${SCRIPT_DIR}/lib/logger.sh"

run_android_detection() {
    detect_system
    log_info "Android Detection: API=${SYS_ANDROID_API}, Termux=${SYS_IS_TERMUX}, Prefix=${SYS_TERMUX_PREFIX}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_android_detection
fi
