#!/usr/bin/env bash
# Cache Management Module
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

CACHE_DIR="${BOOTSTRAP_CACHE_DIR:-$HOME/.termux-bootstrap/cache}"

clean_cache() {
    log_info "Cleaning expired cache files from ${CACHE_DIR}..."
    mkdir -p "${CACHE_DIR}"
    log_success "Cache cleanup complete."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    clean_cache
fi
