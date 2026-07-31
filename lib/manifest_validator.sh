#!/usr/bin/env bash
# ==============================================================================
# Termux Bootstrap Framework - Manifest Schema Validator Engine
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/lib/logger.sh"

validate_manifest_file() {
    local file_path="$1"
    local expected_section="$2"

    if [[ ! -f "${file_path}" ]]; then
        log_error "Manifest file not found: ${file_path}"
        return 1
    fi

    if [[ ! -r "${file_path}" ]]; then
        log_error "Manifest file not readable: ${file_path}"
        return 1
    fi

    # Check for top-level section key
    if ! grep -E -q "^[[:space:]]*${expected_section}:" "${file_path}"; then
        log_error "Manifest ${file_path} missing required top-level key '${expected_section}:'"
        return 1
    fi

    log_debug "Manifest validation passed for $(basename "${file_path}")"
    return 0
}

validate_all_manifests() {
    local manifests_dir="${SCRIPT_DIR}/manifests"
    local ok=0

    log_info "Validating framework declarative YAML manifests..."

    validate_manifest_file "${manifests_dir}/packages.yaml" "packages" || ok=1
    validate_manifest_file "${manifests_dir}/repositories.yaml" "repositories" || ok=1
    validate_manifest_file "${manifests_dir}/installers.yaml" "installers" || ok=1
    validate_manifest_file "${manifests_dir}/plugins.yaml" "plugins" || ok=1
    validate_manifest_file "${manifests_dir}/services.yaml" "services" || ok=1

    if [[ ${ok} -eq 0 ]]; then
        log_success "All manifest files passed schema validation checks."
        return 0
    else
        log_error "One or more manifest schema validations failed!"
        return 1
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    validate_all_manifests
fi
