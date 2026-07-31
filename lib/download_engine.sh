#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Multi-Provider Resilient Download Engine
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"
source "${SCRIPT_DIR}/lib/crypto_verifier.sh"

CACHE_DIR="${BOOTSTRAP_CACHE_DIR:-$HOME/.termux-bootstrap/cache}"

download_file() {
    local primary_url="$1"
    local output_path="$2"
    local expected_hash="${3:-SKIP}"
    local max_retries="${4:-3}"
    shift 4 2>/dev/null || true
    local fallback_urls=("$@")

    mkdir -p "${CACHE_DIR}" "$(dirname "${output_path}")"

    # Check cache first if hash is provided
    if [[ "${expected_hash}" != "SKIP" && -f "${output_path}" ]]; then
        if verify_sha256 "${output_path}" "${expected_hash}" >/dev/null 2>&1; then
            log_debug "File already exists in cache with valid hash: ${output_path}"
            return 0
        fi
    fi

    local urls_to_try=("${primary_url}" "${fallback_urls[@]}")
    local attempt=1
    local success=0

    for url in "${urls_to_try[@]}"; do
        if [[ -z "${url}" ]]; then continue; fi

        log_info "Attempting download from: ${url}"

        for (( attempt=1; attempt<=max_retries; attempt++ )); do
            log_debug "Download attempt ${attempt}/${max_retries} for ${url}"

            local dl_status=1
            if command -v curl >/dev/null 2>&1; then
                curl -sSL --fail --retry 2 --connect-timeout 10 -C - -o "${output_path}" "${url}" && dl_status=0 || dl_status=1
            elif command -v wget >/dev/null 2>&1; then
                wget -q -c --tries=2 --timeout=10 -O "${output_path}" "${url}" && dl_status=0 || dl_status=1
            else
                log_error "Neither curl nor wget is available!"
                return 1
            fi

            if [[ ${dl_status} -eq 0 ]]; then
                if verify_sha256 "${output_path}" "${expected_hash}"; then
                    log_success "Successfully downloaded and verified: ${output_path}"
                    success=1
                    break 2
                else
                    log_warn "Checksum failed on downloaded file from ${url}, retrying..."
                    rm -f "${output_path}"
                fi
            else
                log_warn "Download failed for ${url} (Attempt ${attempt}/${max_retries})"
                sleep 1
            fi
        done
    done

    if [[ ${success} -eq 1 ]]; then
        return 0
    else
        log_error "All mirror sources failed to download: ${primary_url}"
        return 1
    fi
}
