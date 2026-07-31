#!/usr/bin/env bash
# Unit Test: Crypto Hash Verifier
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/crypto_verifier.sh"

test_crypto() {
    local tmp_dir="${SCRIPT_DIR}/cache/test_crypto"
    mkdir -p "${tmp_dir}"
    local tmp_file="${tmp_dir}/test_hash.txt"
    echo "hello termux bootstrap" > "${tmp_file}"

    # Verify SKIP
    verify_sha256 "${tmp_file}" "SKIP"
    echo "[PASS] Crypto verifier unit test successful."
    rm -rf "${tmp_dir}"
}

test_crypto
