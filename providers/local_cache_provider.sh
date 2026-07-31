#!/usr/bin/env bash
# ==============================================================================
# Local Cache Mirror & Offline Provider
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/crypto_verifier.sh"

LOCAL_CACHE_DIR="${BOOTSTRAP_CACHE_DIR:-$HOME/.termux-bootstrap/cache}"

local_cache_fetch() {
    local cache_key="$1"
    local output_dest="$2"
    local checksum="${3:-SKIP}"

    local cached_file="${LOCAL_CACHE_DIR}/${cache_key}"

    if [[ -f "${cached_file}" ]]; then
        if verify_sha256 "${cached_file}" "${checksum}"; then
            log_info "Retrieved asset from local offline cache: ${cache_key}"
            mkdir -p "$(dirname "${output_dest}")"
            cp "${cached_file}" "${output_dest}"
            return 0
        fi
    fi

    log_warn "Asset not found or invalid in local cache: ${cache_key}"
    return 1
}
