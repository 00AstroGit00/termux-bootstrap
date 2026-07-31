#!/usr/bin/env bash
# Unit Test: Offline Mode & Local Cache Provider
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
export BOOTSTRAP_CACHE_DIR="${SCRIPT_DIR}/cache/test_offline"
mkdir -p "${BOOTSTRAP_CACHE_DIR}"

source "${SCRIPT_DIR}/providers/local_cache_provider.sh"

test_offline_mode() {
    log_info "Testing local cache provider for offline resilience..."

    local test_key="dummy_asset.tar.gz"
    echo "test offline content" > "${BOOTSTRAP_CACHE_DIR}/${test_key}"

    local dest="/tmp/test_offline_out.txt"
    if [[ -d "/data/data/com.termux/files/home" ]]; then
        dest="${SCRIPT_DIR}/cache/test_offline_out.txt"
    fi

    local_cache_fetch "${test_key}" "${dest}" "SKIP"

    if [[ ! -f "${dest}" ]]; then
        echo "[FAIL] Offline cache retrieval failed!" >&2
        exit 1
    fi

    echo "[PASS] Offline mode unit test successful."
    rm -rf "${BOOTSTRAP_CACHE_DIR}" "${dest}"
}

test_offline_mode
