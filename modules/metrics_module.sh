#!/usr/bin/env bash
# Metrics & Performance Telemetry Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

metrics_start_timer() {
    date +%s
}

metrics_end_timer() {
    local start_time="$1"
    local end_time
    end_time=$(date +%s)
    local elapsed=$(( end_time - start_time ))
    log_info "Execution completed in ${elapsed} seconds."
    echo "${elapsed}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    s=$(metrics_start_timer)
    sleep 1
    metrics_end_timer "$s"
fi
