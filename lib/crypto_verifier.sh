#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Cryptographic & Integrity Verifier
# ==============================================================================

set -euo pipefail

verify_sha256() {
    local target_file="$1"
    local expected_hash="$2"

    if [[ ! -f "${target_file}" ]]; then
        echo "[ERROR] File not found: ${target_file}" >&2
        return 1
    fi

    if [[ -z "${expected_hash}" || "${expected_hash}" == "SKIP" || "${expected_hash}" == "none" ]]; then
        return 0
    fi

    local actual_hash=""
    if command -v sha256sum >/dev/null 2>&1; then
        actual_hash=$(sha256sum "${target_file}" | awk '{print $1}')
    elif command -v shasum >/dev/null 2>&1; then
        actual_hash=$(shasum -a 256 "${target_file}" | awk '{print $1}')
    elif command -v openssl >/dev/null 2>&1; then
        actual_hash=$(openssl dgst -sha256 "${target_file}" | awk '{print $NF}')
    else
        echo "[WARN] No sha256 tool available, skipping checksum check." >&2
        return 0
    fi

    if [[ "${actual_hash,,}" == "${expected_hash,,}" ]]; then
        return 0
    else
        echo "[ERROR] SHA256 mismatch for ${target_file}! Expected: ${expected_hash}, Actual: ${actual_hash}" >&2
        return 1
    fi
}
