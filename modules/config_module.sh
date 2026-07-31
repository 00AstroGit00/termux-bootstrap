#!/usr/bin/env bash
# Configuration Module Engine
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

run_config_module() {
    log_section "Configuration Engine"
    if [[ -f "${SCRIPT_DIR}/config.env" ]]; then
        source "${SCRIPT_DIR}/config.env"
        log_info "Loaded configuration variables from config.env"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_config_module
fi
