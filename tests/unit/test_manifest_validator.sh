#!/usr/bin/env bash
# Unit Test: Manifest Validator Module
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "${SCRIPT_DIR}/lib/manifest_validator.sh"

test_manifest_validator() {
    log_info "Testing manifest validation..."
    validate_all_manifests
    echo "[PASS] Manifest validator unit test successful."
}

test_manifest_validator
