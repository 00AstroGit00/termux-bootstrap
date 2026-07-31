#!/usr/bin/env bash
# ==============================================================================
# Architecture Detection Module
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/os_detect.sh"
source "${SCRIPT_DIR}/lib/logger.sh"

run_arch_detection() {
    detect_system
    log_info "Architecture Detection: Architecture=${SYS_ARCH}, CPU Cores=${SYS_CPU_CORES}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_arch_detection
fi
