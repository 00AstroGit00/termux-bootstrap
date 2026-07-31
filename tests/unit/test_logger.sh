#!/usr/bin/env bash
# Unit Test: Logger Module
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

test_logger() {
    log_info "Testing log_info..."
    log_success "Testing log_success..."
    log_warn "Testing log_warn..."
    echo "[PASS] Logger unit test successful."
}

test_logger
