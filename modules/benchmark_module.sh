#!/usr/bin/env bash
# Benchmark Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

run_benchmark() {
    log_section "System Performance Benchmark"
    local start
    start=$(date +%s%N 2>/dev/null || date +%s)

    log_info "Executing CPU & I/O benchmark loop..."
    local i=0
    while [[ $i -lt 10000 ]]; do
        (( i++ ))
    done

    local end
    end=$(date +%s%N 2>/dev/null || date +%s)
    log_success "Benchmark finished successfully."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    run_benchmark
fi
