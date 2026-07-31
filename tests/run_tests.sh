#!/usr/bin/env bash
# ==============================================================================
# Master Automated Test Suite Runner
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "================================================================="
echo "Running Termux Bootstrap Automated Test Suite"
echo "================================================================="

unit_tests=(
    "${SCRIPT_DIR}/tests/unit/test_logger.sh"
    "${SCRIPT_DIR}/tests/unit/test_os_detect.sh"
    "${SCRIPT_DIR}/tests/unit/test_state_db.sh"
    "${SCRIPT_DIR}/tests/unit/test_crypto_verifier.sh"
    "${SCRIPT_DIR}/tests/unit/test_manifest_validator.sh"
    "${SCRIPT_DIR}/tests/unit/test_offline_mode.sh"
)

integration_tests=(
    "${SCRIPT_DIR}/tests/integration/test_doctor.sh"
    "${SCRIPT_DIR}/tests/integration/test_repair.sh"
    "${SCRIPT_DIR}/tests/integration/test_rollback_recovery.sh"
)

passed=0
failed=0

for t in "${unit_tests[@]}"; do
    if [[ -f "${t}" ]]; then
        echo "Running Unit Test: $(basename "${t}")"
        if bash "${t}"; then
            (( passed++ )) || true
        else
            (( failed++ )) || true
        fi
    fi
done

for t in "${integration_tests[@]}"; do
    if [[ -f "${t}" ]]; then
        echo "Running Integration Test: $(basename "${t}")"
        if bash "${t}"; then
            (( passed++ )) || true
        else
            (( failed++ )) || true
        fi
    fi
done

echo "================================================================="
echo "Test Suite Execution Results: ${passed} Passed, ${failed} Failed"
echo "================================================================="

if [[ ${failed} -eq 0 ]]; then
    exit 0
else
    exit 1
fi
